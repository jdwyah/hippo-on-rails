class TopicsPropertyType < ActiveRecord::Base
  
  belongs_to :property_type
  belongs_to :topic
  
end
