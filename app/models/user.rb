class User < ApplicationRecord
  validates_presence_of :email, :password, :password_confirmation

  has_secure_password
  has_secure_token :api_key

  def self.authenticate_token(token)
    where(api_key: token).any?
  end
end
