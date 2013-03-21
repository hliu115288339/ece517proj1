class Post < ActiveRecord::Base
  attr_accessible :title, :content, :user_id, :category_id, :parent_post_id

  belongs_to :category
  belongs_to :user
  has_many :votes, foreign_key: "post_id", :dependent => :destroy

  has_many :comments, class_name: "Post", foreign_key: "parent_post_id", :dependent => :destroy
  belongs_to :parent_post, class_name: "Post"

  #default_scope order: 'posts.updated_at DESC'

  validates :title,
            presence: true,
            length: { minimum: 5 }
  validates :category_id,
            presence: true
  validates :content,
            presence: true,
            length: { minimum: 10 }
  validates :user_id,
            presence: true

  def voted?(user)
    votes.find_by_user_id(user.id)
  end

  #def vote!(user)
  #  votes.create!(user_id: user.id)
  #end
  #
  #def unvote!(user)
  #  votes.find_by_user_id(user.id).destroy
  #end

  def self.search(search)
    if search
      find(:all, :conditions => ['content LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

end
