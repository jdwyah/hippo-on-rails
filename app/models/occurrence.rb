class Occurrence < ActiveRecord::Base
  
  has_many :topics, :through => :topics_occurrences
  
end
