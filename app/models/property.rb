class Property < ActiveRecord::Base
  
  belongs_to :topic
  belongs_to :property_type
  
end
