class PropertyType < ActiveRecord::Base
  
  VALID_TYPES = %w( String Date Location )
  
  has_many :topics_property_types
  has_many :topics, :through => :topics_property_types
  has_many :properties
  
  validates_inclusion_of :type_name, :in => VALID_TYPES
  
end