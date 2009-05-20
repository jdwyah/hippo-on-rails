class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :topics, :through => :topics_topics, :source => :to
  has_many :topics_topics, :class_name => 'TopicsTopic', :foreign_key => :from_id
end
