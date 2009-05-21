class CreatePropertyTypes < ActiveRecord::Migration
  def self.up
    create_table :property_types do |t|
      t.integer :topic_id
      t.string :name, :type
      t.timestamps
    end
  end

  def self.down
    drop_table :property_types
  end
end
