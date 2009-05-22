class WackPropertyTypeTopicField < ActiveRecord::Migration
  def self.up
    remove_column :property_types, :topic_id
  end

  def self.down
    add_column :property_types, :topic_id, :integer
  end
end
