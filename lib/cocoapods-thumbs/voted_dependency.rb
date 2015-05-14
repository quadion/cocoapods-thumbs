module Pod
  
  module Thumbs
    
    class VotedDependency
      
      attr_accessor :dependency
      attr_accessor :votes
      
      delegate :name, :to => :dependency
      
      def initialize(dependency, votes)
        @dependency = dependency
        @votes = votes.map { |v| v.is_a?(Hash) ? DependencyVote.new(v) : v }
      end
      
      def up_votes
        @votes.select { |v| v.type == :up }
      end
      
      def down_votes
        @votes.select { |v| v.type == :down }
      end
      
      def satisfied_by?(version)
        @dependency.requirement.satisfied_by? version
      end
      
      def votes_summary_string
        result = []
        result << "+#{up_votes.count}".green if up_votes.count > 0
        result << "-#{down_votes.count}".red if down_votes.count > 0
        result.join(" ")
      end
      
    end
    
  end
  
end