require File.expand_path('../spec_helper', __FILE__)

module Pod
  
  describe Thumbs::VotesList do
    
    def greater_than(number)
      lambda { |obj| obj > number }
    end
    
    before do
      @voted_list = Thumbs::VotesList.new(IO.read(File.new(File.expand_path('../fixtures/list.json', __FILE__))))
    end
    
    it 'should properly parse the JSON thumbs file' do
      @voted_list.should.not.be.nil
    end
    
    it 'should have some voted dependencies' do
      @voted_list.voted_dependencies.should.not.be.nil
    end
    
    it 'should have a non empty list of voted dependencies' do
      @voted_list.voted_dependencies.count.should.be greater_than(0)
    end
    
    it 'should include AFNetworking and EGOTableViewPullRefresh as voted dependencies' do
      @voted_list.voted_dependencies.find { |o| o.name == 'AFNetworking' }.should.not.be.nil
      @voted_list.voted_dependencies.find { |o| o.name == 'EGOTableViewPullRefresh' }.should.not.be.nil
    end
    
    it 'can find a VotedDependency by its name and satisfied version' do
      @voted_list.find('AFNetworking', Version.new('2.5.3')).should.not.be.nil
      @voted_list.find('AFNetworking', Version.new('2.5.3')).count.should.be.equal 1
      @voted_list.find('AFNetworking', Version.new('2.5.3')).should.be.kind_of Array
    end
    
    it 'can return multiple VotedDependency entries' do
      @voted_list.find('AFNetworking', Version.new('2.5.2')).count.should.be.equal 2
    end
    
  end
  
end