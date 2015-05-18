module Pod
  module Thumbs
    
    class Configuration
      
      def self.config_file_path
        File.expand_path('~/.cocoapods-thumbs.yaml')
      end
      
      def self.exists?
        begin
          YAML::load(IO.read(config_file_path))
          true
        rescue
          false
        end
      end
      
      def self.load
        YAML.load_file(config_file_path)
      end
      
      def self.set_url(url)
        config = { url: url }
        
        File.open(config_file_path, 'w') { |f| f.write config.to_yaml }
      end
      
    end
    
  end
end