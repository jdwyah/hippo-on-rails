class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.integer :topic_id, :property_type_id
      t.text :value 
      t.timestamps
    end
  end

  def self.down
    drop_table :properties
  end
end
