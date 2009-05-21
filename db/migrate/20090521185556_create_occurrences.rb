class CreateOccurrences < ActiveRecord::Migration
  def self.up
    create_table :occurrences do |t|
      t.integer :topic_id
      t.string :name
      t.text :text
      t.timestamps
    end
  end

  def self.down
    drop_table :occurrences
  end
end