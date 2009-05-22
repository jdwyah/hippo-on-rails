class PropertyType < ActiveRecord::Base
  
  VALID_TYPES = %w( String Date Location )
  
  validates_inclusion_of :type_name, :in => VALID_TYPES
  
  belongs_to :topic
  
end
