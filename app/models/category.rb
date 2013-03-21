class Category < ActiveRecord::Base
  has_many :posts, :dependent => :destroy

  attr_accessible :name

  validates :name,
            presence: true,
            length: { minimum: 2 }

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end


end
