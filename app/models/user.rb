# frozen_string_literal: true

class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true,
               format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username,
        presence: true,
        uniqueness: true,
        length: { in: 3..20 },
        format: {
            with: /\A[a-zA-Z0-9_-]+\z/,
            message: "can only contain letters, numbers, underscore, and hyphen"
        }
    validates :password, presence: true, length: { minimum: 6 }
    
    enum role: { super_admin: 0, admin: 1 }

    before_save :downcase_email

    private

    def downcase_email
        self.email = email.downcase
    end
end
