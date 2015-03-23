require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Thumbs do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ thumbs }).should.be.instance_of Command::Thumbs
      end
    end
  end
end

