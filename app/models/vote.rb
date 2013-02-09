class Vote < ActiveRecord::Base
  attr_accessible :user_id, :post_id

  belongs_to :user, class_name: "User"
  belongs_to :post, class_name: "Post"

  validates :user_id,
            presence: true

  validates :post_id,
            presence: true

end
