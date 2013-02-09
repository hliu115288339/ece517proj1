class Post < ActiveRecord::Base
  attr_accessible :title, :content, :user_id, :category_id

  belongs_to :category
  belongs_to :user
  has_many :votes, foreign_key: "post_id", dependent: :destroy

  default_scope order: 'posts.updated_at DESC'

  validates :title,
            presence: true,
            length: { minimum: 5 }
  validates :content,
            presence: true,
            length: { minimum: 20 }
  validates :user_id,
            presence: true

  def voted?(user)
    votes.find_by_user_id(user.id)
  end

  def vote!(user)
    votes.create!(user_id: user.id)
  end

  def unvote!(user)
    votes.find_by_user_id(user.id).destroy
  end

end
