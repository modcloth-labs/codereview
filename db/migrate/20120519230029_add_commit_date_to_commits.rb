class AddCommitDateToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :commit_date, :date
  end
end
