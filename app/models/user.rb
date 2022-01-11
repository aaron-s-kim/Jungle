class User < ActiveRecord::Base
  
  # Adds methods to set & authenticate against a BCrypt password.
  # This requires you to have a XXX_digest attribute where XXX is attribute name of desired password.
  has_secure_password # gives User model authentication methods via bcrypt

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6}

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.downcase.strip)

    # If user exists AND password entered is correct.
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

end
