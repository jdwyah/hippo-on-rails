class Topic < ActiveRecord::Base
  
  has_many :properties
  has_many :property_types
  has_and_belongs_to_many :tags, :class_name => 'Topic', :join_table => :topics_topics, :foreign_key => :child_id, :association_foreign_key => :parent_id
  has_and_belongs_to_many :topics, :class_name => 'Topic', :join_table => :topics_topics, :foreign_key => :parent_id, :association_foreign_key => :child_id
  has_many :occurrences, :through => :topics_occurrences
  
end