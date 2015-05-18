module Pod
  class Command
    class Thumbs
      class Server < Thumbs
        self.summary = 'Configures the thumbs server URL.'
        self.arguments = [
          CLAide::Argument.new('URL', true),
        ]

        def initialize(argv)
          @url = argv.shift_argument
          super
        end

        def validate!
          help! 'Please specify a server URL.' unless @url
        end

        def run
          Pod::Thumbs::Configuration.set_url(@url)
          
          UI.title("Server configured") do
            UI.labeled 'URL', @url
          end
        end
      end
    end
  end
end
