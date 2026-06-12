# frozen_string_literal: true

class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true,
               format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :encrypted_password, presence: true
    enum role: { super_admin: 0, admin: 1 }

    before_save :encrypt_password, :downcase_email

    private

    def downcase_email
        self.email = email.downcase
    end

    def encrypt_password
        self.encrypted_password = BCrypt::Password.create(encrypted_password) if encrypted_password_changed?
    end
end
