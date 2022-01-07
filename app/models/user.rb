class User < ActiveRecord::Base
  
  # gives User model authentication methods via bcrypt
  has_secure_password

end
