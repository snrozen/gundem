class Message < ActiveRecord::Base
  attr_accessible :category_id, :content, :name, :user_id

  belongs_to :category
  belongs_to :user

end
