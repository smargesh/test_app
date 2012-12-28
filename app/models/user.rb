class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation
  
   
  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true, :length => { :minimum => 6,:message => "password must be at least 6 characters long" }, :confirmation =>true

  before_save :encrypt_password

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password == BCrypt::Engine.hash_secret(password, user.password_hash)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_hash = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, password_hash)
    end
  end
   
end
