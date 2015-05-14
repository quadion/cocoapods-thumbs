require File.expand_path('../spec_helper', __FILE__)

module Pod
  
  describe Thumbs::VotedDependency do
    before do
      votes = [
        Thumbs::DependencyVote.new(type: :up, voter: '@user1', comment: 'Excelent'),
        Thumbs::DependencyVote.new(type: :up, voter: '@user2', comment: 'Excelent'),
        Thumbs::DependencyVote.new(type: :down, voter: '@user3', comment: "Don't use this please."),
      ]
      @voted_dependency = Thumbs::VotedDependency.new(Pod::Dependency.new('AFNetworking', '~> 2.5'), votes)
    end
    
    it 'has a cocoapods dependency' do
      @voted_dependency.dependency.should.not.be.nil
    end
    
    it 'has an array of votes' do
      @voted_dependency.votes.should.not.be.nil
    end
    
    it 'has some upvotes' do
      @voted_dependency.up_votes.count.should.be.equal 2
    end
    
    it 'has upvotes as instances of DependencyVote' do
      @voted_dependency.up_votes.first.class.should.be.equal Thumbs::DependencyVote
    end
    
    it 'has some downvotes' do
      @voted_dependency.down_votes.count.should.be.equal 1
    end
    
    it 'has downvotes as instances of DependencyVote' do
      @voted_dependency.down_votes.first.class.should.be.equal Thumbs::DependencyVote
    end
    
    it 'has DependencyVote instances as votes' do
      @voted_dependency.votes.count.should.be.equal 3
      @voted_dependency.votes.first.class.should.be.equal Thumbs::DependencyVote
    end
    
    it 'initializes its votes from an array of hashes and turns them into DependencyVote' do
      votes = [
        {
            "type" => "up",
            "voter" => "@pbendersky",
            "comment" => "Excellent library!"
        }
      ]
      voted_dependency = Thumbs::VotedDependency.new(Pod::Dependency.new, votes)
      
      voted_dependency.votes.first.should.be.kind_of Thumbs::DependencyVote
    end
    
    it 'can be satisfied by a version' do
      @voted_dependency.satisfied_by?(Version.new('2.5.3')).should.be.true
      @voted_dependency.satisfied_by?(Version.new('2.4.2')).should.be.false
    end
    
    it 'can return a colored string with a summary of its votes' do
      @voted_dependency.votes_summary_string.should.equal "#{"+2".green} #{"-1".red}"
    end
    
  end
  
end