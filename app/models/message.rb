class Message < ActiveRecord::Base
  attr_accessible :category_id, :content, :name

  belongs_to :category
end
