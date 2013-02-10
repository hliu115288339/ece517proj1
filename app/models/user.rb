class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :admin
  has_secure_password

  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :votes, foreign_key: "user_id", :dependent => :destroy

  before_save { |user| user.email = email.downcase}
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username,
            presence: true,
            uniqueness: true,
            length: { in: 3..50 }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  validates :password,
            presence: true,
            confirmation: true,  #password_confirmation attr
            length: { in: 6..50 }

  validates :password_confirmation,
           presence: true

  def voted?(post)
    votes.find_by_post_id(post.id)
  end

  def vote!(post)
    votes.create!(post_id: post.id)
  end

  def unvote!(post)
    votes.find_by_post_id(post.id).destroy
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
