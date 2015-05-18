require File.expand_path('../../spec_helper', __FILE__)

module Pod
  
  require 'cocoapods-thumbs/configuration'
  
  describe Command::Thumbs do
    
    before do
      Pod::Config.any_instance.stubs(:podfile).returns(Pod::Podfile.new(Pathname.new(ROOT + '/specs/fixtures/Podfile')))
      Pod::Config.any_instance.stubs(:integrate_targets?).returns(false)
      Pod::Thumbs::Configuration.stubs(:config_file_path).returns(File.new(ROOT + 'spec/fixtures/.cocoapods-thumbs.yaml'))
      Pod::Command::Thumbs.any_instance.stubs(:verify_config_exists!).returns(true)
    end
    
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ thumbs }).should.be.instance_of Command::Thumbs
      end
      
      it 'can accept a comments parameter' do
        command = Command.parse(%w{ thumbs --comments })
        lambda { command.validate! }.should.not.raise CLAide::Help
      end
      
      it 'can accept a platform parameter' do
        command = Command.parse(%w{ thumbs AFNetworking 2.5.3 --platform=ios })
        lambda { command.validate! }.should.not.raise CLAide::Help
      end
      
      it 'can accept ios as a platform' do
        command = Command.parse(%w{ thumbs AFNetworking 2.5.3 --platform=ios })
        lambda { command.validate! }.should.not.raise CLAide::Help
      end
      
      it 'can accept osx as a platform' do
        command = Command.parse(%w{ thumbs AFNetworking 2.5.3 --platform=osx })
        lambda { command.validate! }.should.not.raise CLAide::Help
      end
      
      it 'fails with anything other than ios or osx as a platform' do
        command = Command.parse(%w{ thumbs AFNetworking 2.5.3 --platform=win })
        lambda { command.validate! }.should.raise Pod::Informative
      end
      
      it 'can optionally receive a spec name' do
        command = Command.parse(%w{ thumbs AFNetworking })
        lambda { command.run }.should.not.raise CLAide::Help
      end

      it 'can optionally receive a spec name and a requirements string' do
        command = Command.parse(%w{ thumbs AFNetworking 2.5 })
        lambda { command.run }.should.not.raise CLAide::Help
      end

    end
  end
end

