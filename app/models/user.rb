class User < ActiveRecord::Base
  
  # Adds methods to set & authenticate against a BCrypt password.
  # This requires you to have a XXX_digest attribute where XXX is attribute name of desired password.
  has_secure_password # gives User model authentication methods via bcrypt

  # validates :name, presence: true
  # validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false}

end
