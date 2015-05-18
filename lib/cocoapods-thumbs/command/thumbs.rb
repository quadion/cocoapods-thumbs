require 'yaml'
require 'rest'

require 'cocoapods-thumbs/voted_dependency'
require 'cocoapods-thumbs/votes_list'
require 'cocoapods-thumbs/dependency_vote'
require 'cocoapods-thumbs/user_interface'
require 'cocoapods-thumbs/configuration'

module Pod
  class Command

    class Thumbs < Command
      self.summary = "Use cocoapods-thumbs to upvote or downvote Pods based on past experiences."

      self.description = <<-DESC
        Use cocoapods-thumbs to upvote or downvote Pods based on past experiences.
      DESC
      
      self.arguments = [
        CLAide::Argument.new('NAME',           false),
        CLAide::Argument.new('REQUIREMENT',    false),
      ]
      
      # @return [Pathname]
      #
      THUMBS_TMP_DIR = Pathname.new('/tmp/CocoaPods/Thumbs')
      
      DEFAULT_PLATFORM_VERSIONS = {
        :ios => '8.3',
        :osx => '10.10'
      }
      
      require 'cocoapods-thumbs/command/thumbs/server'
      
      attr_accessor :name, :requirement, :platform, :platform_version

      def initialize(argv)
        @comments = argv.flag?('comments')
        @platform = argv.option('platform', 'ios').to_sym
        @platform_version = argv.option('version', DEFAULT_PLATFORM_VERSIONS[@platform])
        @name, @requirement = argv.shift_argument, argv.shift_argument
        @requirement ||= Pod::Requirement.default.to_s
        super
      end
      
      def self.options
        [
          ['--comments', 'Display user comments alongside votes.'],
          ['--platform', 'When specifying a Podname the platform to use for calculating dependencies. Valid values: ios / osx. Defaults to ios.'],
          ['--version', 'When specifying a platform, use this option to set a version different than the default (iOS 8.3 and OS X 10.10)']
        ].concat(super)
      end

      def validate!
        super
        verify_config_exists!
        verify_podfile_exists! if @name.nil?
        verify_valid_platform! unless @name.nil?
      end

      def run
        @configuration = Pod::Thumbs::Configuration.load
        @rest = Rest::Client.new
        @votes_list = Pod::Thumbs::VotesList.new(@rest.get(@configuration[:url]).body)
        
        configure_sandbox_and_podfile
        
        sandbox = @sandbox
        podfile = @podfile
        analyzer = Installer::Analyzer.new(
          sandbox,
          podfile,
          nil
        )

        specs = analyzer.analyze(false).specs_by_target.values.flatten(1)
        
        specs.each do |spec|
          voted_dependencies = @votes_list.find(spec.name, spec.version)
          if ! voted_dependencies.empty? then
            UI.section "#{spec.name} #{spec.version}" do
              voted_dependencies.each do |voted_dependency|
                UI.marked_labeled "", voted_dependency.dependency.requirement, voted_dependency.votes_summary_string
                if @comments then
                  UI.indented_block do
                    voted_dependency.votes.select {|v| v.comment != nil }.each do |vote|
                      UI.marked_labeled vote.type_string, vote.voter, vote.comment, 15
                    end
                  end
                end
              end
            end
          end
        end
      end
      
      private
      
      def configure_sandbox_and_podfile
        if @name then
          parent = self
          config.integrate_targets = false
          @podfile = Pod::Podfile.new do |pod|
            pod.pod parent.name, parent.requirement
            pod.xcodeproj 'Thumbs.xcodeproj'
            pod.platform parent.platform, parent.platform_version
          end
        
          @sandbox = Pod::Sandbox.new(THUMBS_TMP_DIR)
        else
          @podfile = config.podfile
          @sandbox = config.sandbox
        end
      end
      
      def verify_config_exists!
        unless Pod::Thumbs::Configuration.exists?
          raise Informative, "No cocoapods-thumb configuration file found on your home directory. Run `pod thumbs server'."
        end
      end
      
      def verify_valid_platform!
        if ! [:ios, :osx].include? @platform
          raise Informative, 'platform must be either ios or osx'
        end
      end
      
    end
  end
end
