class Commit < ActiveRecord::Base
  PATH_TO_REPO = YAML.load(File.read 'config/git.yml')[:path]

  scope :new_commits, where("is_new = ?", true).order('commit_date desc')
  scope :rejected,    where("is_new = ? AND accepted = ?", false, false).order('commit_date desc')
  scope :accepted,    where("is_new = ? AND accepted = ?", false, true).order('commit_date desc')
  scope :in_review,   where("started = ? AND accepted = ?", true, false).order('commit_date desc')

  def accept!
    update_attributes(accepted: true, is_new: false)
  end
  
  def reject!
    update_attributes(accepted: false, is_new: false)
  end
  
  def restart!
    update_attributes(started: false, accepted: false, is_new: true)
  end
  
  def review!
    update_attributes(started: true, accepted: false)
  end
  
  def rejected?
    not accepted? and not is_new?
  end
  
  def self.sync
    commits     = Commit.all.map(&:refid)
    repo        = Grit::Repo.new(PATH_TO_REPO)
    new_commits = repo.commits('master', 20).reject{ |c| commits.include? c.id }
    new_commits.each do |c|
      Commit.new(
        :refid       => c.id,
        :author      => c.author.name,
        :message     => c.message,
        :commit_date => c.date,
      ).save
    end
  end

  def self.restart
    Commit.delete_all
  end
end
