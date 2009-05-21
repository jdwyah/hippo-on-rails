class PropertyTypeStiConflict < ActiveRecord::Migration
  def self.up
    rename_column :property_types, :type, :type_name
  end

  def self.down
    rename_column :property_types, :type_name, :type
  end
end
