class CreateCommits < ActiveRecord::Migration

  def self.up
    create_table :commits do |t|
      t.string  :refid
      t.string  :author
      t.string  :message
      t.boolean :accepted, :default => nil
      t.boolean :is_new,   :default => true
      t.boolean :started,  :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :commits
  end
end
