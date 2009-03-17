class User < ActiveRecord::Base
  has_many :topics
end
