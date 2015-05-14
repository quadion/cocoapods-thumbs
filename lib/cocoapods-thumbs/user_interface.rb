module Pod
  module UserInterface
    
    class << self
      
      # Changes the indentation level and yields to the given block.
      # Useful to call succesive UI methods and have their content be indented.
      def indented_block(relative_indentation = 2)
        self.indentation_level += relative_indentation
        
        yield if block_given?
        
        self.indentation_level -= relative_indentation
      end
      
      # Prints a message with a label and a given marker, instead of the standard hyphen.
      #
      def marked_labeled(marker, label, value, justification = 12)
        if value
          title = "#{marker} #{label}: "
          puts wrap_string(title.ljust(justification) + "#{value}", self.indentation_level)
        end
      end
      
      
    end
    
  end
end