class User < ActiveRecord::Base
  validates_presence_of :name, :username, :email
  validates_uniqueness_of :name, :username, :email
  has_secure_password
  has_many :appointments

end
