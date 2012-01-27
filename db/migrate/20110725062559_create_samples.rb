class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.string :refid
      t.string :reviewer

      t.timestamps
    end
  end

end
