module Pod
  
  module Thumbs
    
    class DependencyVote
      
      attr_accessor :type
      attr_accessor :voter
      attr_accessor :comment
      
      def initialize(options = {})
        self.type = options[:type]
        self.voter = options[:voter]
        self.comment = options[:comment]
      end
      
      def type=(type)
        if type.is_a? String then
          @type = type.to_sym
        else
          @type = type
        end
      end
      
      def type_string
        @type == :up ? "+".green : "-".red
      end
      
    end

  end

end