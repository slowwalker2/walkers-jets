class User < ApplicationRecord
  has_secure_password validations: true

  class << self
    def new_remember_token
      SecureRandom.urlsafe_base64
    end

    def encrypt(token)
      Digest::SHA256.hexdigest(token.to_s)
    end
  end
end
