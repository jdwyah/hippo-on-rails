class TopicsTopic < ActiveRecord::Base
  belongs_to :to, :class_name => 'Topic', :foreign_key => 'to_id'
  belongs_to :from, :class_name => 'Topic', :foreign_key => 'from_id'
end