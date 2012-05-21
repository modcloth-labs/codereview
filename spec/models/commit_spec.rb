require 'spec_helper'

describe Commit do
  before do
    @commits    = Array.new(20){ |id| FactoryGirl.create(:commit, refid: id) }
    @gitentries = Array.new(40){ |id| double(id: id, author: double(name: anything), message: anything, date: anything) }
  end
  
  describe "::sync" do
    let(:commit) { mock_model Commit }
    
    before do
      Commit.stub(:new => commit)
      commit.stub(:save => true)
      Grit::Repo.any_instance.stub(:commits).and_return(@gitentries)
    end
  
    context "synching when no commits have been recorded ye" do
      before { Commit.stub(:all => []) }
      
      it "should sync every commit it can find" do
        Commit.should_receive(:new).with(any_args).exactly(@gitentries.count).times
        Commit.sync
      end
    end
    
    context "synching when some commits have already been recorded" do
      before { Commit.stub(:all => @commits) }
      
      it "should only sync the commits that have not been recorded yet" do
        Commit.should_receive(:new).with(any_args).exactly(@gitentries.count - @commits.count).times
        Commit.sync
      end
    end
  end
end
