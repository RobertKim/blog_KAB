class User < ActiveRecord::Base
  has_many :posts

  validates :name, :email, :password_hash, presence => true
  validates :email, :uniqueness => true
end
