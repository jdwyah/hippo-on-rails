class CreateTopicTopicProperties < ActiveRecord::Migration
  def self.up
    create_table :topics_property_types do |t|
      t.integer :topic_id, :property_type_id
    end
  end

  def self.down
    drop_table :topics_property_types
  end
end
