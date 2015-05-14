require File.expand_path('../spec_helper', __FILE__)

module Pod
  
  describe Thumbs::DependencyVote do
    before do
      # votes = [
      #   DependencyVote.new(name: 'AFNetworking', type: :up, voter: '@pbendersky', comment: 'Excelent'),
      # ]
      @dependency_vote = Thumbs::DependencyVote.new(type: :up, voter: '@pbendersky', comment: 'Nice')
      @dependency_down_vote = Thumbs::DependencyVote.new(type: :down, voter: '@pbendersky', comment: 'Nice')
    end
    
    it 'has a type' do
      @dependency_vote.type.should.equal :up
    end
    
    it 'has a voter' do
      @dependency_vote.voter.should.equal '@pbendersky'
    end
    
    it 'may have a comment' do
      @dependency_vote.comment.should.equal 'Nice'
    end
    
    it 'can be initialized from a hash' do
      hash = { type: :up, voter: '@pbendersky', comment: 'Nice' }
      
      dependency_vote = Thumbs::DependencyVote.new(hash)
      
      dependency_vote.type.should.be.equal :up
      dependency_vote.voter.should.be.equal '@pbendersky'
      dependency_vote.comment.should.be.equal 'Nice'
    end

    it 'has a string representation of its up / down type' do
      @dependency_vote.type_string.should.be.equal "+".green
      @dependency_down_vote.type_string.should.be.equal "-".red
    end

  end
  
end