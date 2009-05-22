class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :properties
  has_many :topics_property_types
  has_many :property_types, :through => :topics_property_types
  has_and_belongs_to_many :tags, :class_name => 'Topic', :join_table => :topics_topics, :foreign_key => :child_id, :association_foreign_key => :parent_id
  has_and_belongs_to_many :topics, :class_name => 'Topic', :join_table => :topics_topics, :foreign_key => :parent_id, :association_foreign_key => :child_id
  has_many :occurrences, :through => :topics_occurrences
  
  accepts_nested_attributes_for :property_types, :allow_destroy => true
  
  def properties_to_use
    tags.map(&:property_types).flatten
  end
  
  def setup_properties
    properties_to_use.each do |property_type|
      properties.build(:property_type_id => property_type.id) unless property_type_ids.include?(property_type.id)
    end
  end
  
  def property_type_ids
    properties.map(&:property_type_id)
  end
  
end