class User < ActiveRecord::Base
  validates_presence_of :name, :username, :email
  validates_uniqueness_of :name, :username, :email
  has_secure_password
  has_many :users

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
