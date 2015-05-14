require 'json'

module Pod
  module Thumbs
    
    class VotesList
      
      attr_reader :voted_dependencies
      
      def initialize(json_list_url)
        list = JSON.parse(json_list_url, {:symbolize_names => true})
        
        @voted_dependencies = Array.new
        
        list[:thumbs].each do |entry|
          voted_dependency = VotedDependency.new(Pod::Dependency.new(entry[:name], entry[:version]), entry[:votes])
          
          @voted_dependencies << voted_dependency
        end
      end
      
      def find(name, version_requirement)
        @voted_dependencies.select { |vd| vd.name == name and vd.satisfied_by? version_requirement }
      end
      
    end
    
  end
end