require 'grit'

class Commit < ActiveRecord::Base
  PATH_TO_REPO = '~/code/modcloth/codereview'

  scope :new_commits, where("is_new == ?", true).order('commit_date desc')
  scope :rejected,    where("is_new == ? AND accepted <> ?", false, true).order('commit_date desc')

  def self.sync
    commits     = Commit.all.map(&:refid)
    repo        = Grit::Repo.new(PATH_TO_REPO)
    new_commits = repo.commits('master', 20).reject{ |c| 
      puts "x #{c.message}"
      commits.include? c.id 
    }

    new_commits.each{ |c|
      Commit.new(
        :refid       => c.id,
        :author      => c.author.name,
        :message     => c.message,
        :commit_date => c.date,
        :accepted    => nil,
        :is_new      => true
      ).save
    }
  end

  def self.restart
    Commit.delete_all
  end
end
