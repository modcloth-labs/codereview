require 'grit'

class Commit < ActiveRecord::Base

  scope :new_commits, where("is_new == ?",true)
  scope :rejected, where("is_new == ? AND accepted <> ?",false,true)

  def self.sync
    commits = Commit.all.map(&:refid)
    #repo = Grit::Repo.new('/Users/modcloth/workspace/codereview')
    #new_commits = repo.commits('sphere_dsc_filter',20).select{|c| c.message.include? '[DSC]'}.reject{|c| commits.include? c.id}
    repo = Grit::Repo.new('~/Dev/codereview')
    new_commits = repo.commits('master',20).reject{|c| commits.include? c.id}

    new_commits.each{ |c|
      Commit.new(
        :refid => c.id,
        :author => c.author.name,
        :message => c.message,
        :accepted => nil,
        :is_new => true
      ).save

    }
  end

  def self.restart
    Commit.delete_all
  end
end
