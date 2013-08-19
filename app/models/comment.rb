class Comment < ActiveRecord::Base
  attr_accessible :content, :dislike, :like, :message_id, :user_id

  belongs_to :message
  belongs_to :user
end
