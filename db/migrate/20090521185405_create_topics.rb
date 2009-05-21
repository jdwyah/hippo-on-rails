class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end
    
     create_table :topics_topics, :id => false do |t|
       t.integer :parent_id, :child_id
     end
     add_index :topics_topics, :parent_id
     add_index :topics_topics, :child_id
  end

  def self.down
    drop_table :topics
  end
end
