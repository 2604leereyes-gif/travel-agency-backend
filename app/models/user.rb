class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true,
               format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :email, presence: true, uniqueness: true
    validates :encrypted_password, presence: true

    before_save :encrypt_password
    
    private
    
    def encrypt_password
        self.encrypted_password = BCrypt::Password.create(encrypted_password) if encrypted_password_changed?
    end
end
