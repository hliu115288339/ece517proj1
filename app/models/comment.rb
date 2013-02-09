class Comment < ActiveRecord::Base
  belongs_to :post or :comments
  belongs_to :user
  has_many :comments


  attr_accessible :title, :body, :post_id, :user_id

  default_scope order: 'comments.updated_at DESC'


end
