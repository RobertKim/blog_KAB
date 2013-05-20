class User < ActiveRecord::Base
  include BCrypt
  has_many :posts

  validates :first_name, :last_name, :email, :username, :password_hash, :presence => true
  validates :username, :email, :uniqueness => true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
