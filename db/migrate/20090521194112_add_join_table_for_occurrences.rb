class AddJoinTableForOccurrences < ActiveRecord::Migration
  def self.up
    change_table :occurrences do |t|
      t.remove :topic_id
    end
    
    create_table :topics_occurrences do |t|
      t.integer :topic_id, :occurrence_id
    end
  end

  def self.down
    change_table :occurrences do |t|
      t.integer :topic_id
    end
    
    drop_table :topics_occurrences
  end
end
