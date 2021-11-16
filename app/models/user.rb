class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, :uniqueness => { :case_sensitive => false }
  validates :password_digest, presence: true, length: { minimum: 5 }

  def authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.find_by(email: email)
    if user
      logged_in = user.authenticate(password)
      if logged_in
        return user
      else
        return nil
      end
    else
      return nil
    end
  end

end
