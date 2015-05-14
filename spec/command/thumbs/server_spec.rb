require File.expand_path('../../../spec_helper', __FILE__)

module Pod
  describe Command::Thumbs::Server do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ thumbs server }).should.be.instance_of Command::Thumbs::Server
      end
      
      it "should error if we don't get a server URL" do
        command = Command.parse(%w( thumbs server ))
        exception = lambda { command.validate! }.should.raise CLAide::Help
        exception.message.should.include 'specify a server URL'
      end
      
      it "should set the new URL for the server and print it back to the user" do
        test_server = "https://github.com/pbendersky/thumbs/raw/master/list.json"
        command = Command.parse(%W( thumbs server #{test_server} ))
        lambda { command.validate! }.should.not.raise CLAide::Help
        command.run
        UI.output.should.include test_server
      end
      
    end
  end
end

