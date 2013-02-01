class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  attr_accessible :title, :body, :post_id, :user_id


end
