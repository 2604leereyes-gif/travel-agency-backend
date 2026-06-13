# frozen_string_literal: true

class JwtService
  ALGORITHM = "HS256"
  SECRET_KEY = ENV.fetch("JWT_SECRET")

  class << self
    # CREATE TOKEN
    def encode(payload, exp = Rails.application.config_for(:settings)[:jwt][:expiry_hours])
      payload = payload.merge(exp: exp.to_i)

      JWT.encode(payload, SECRET_KEY, ALGORITHM)
    end

    # VERIFY + DECODE TOKEN
    def decode(token)
      decoded = JWT.decode(
        token,
        SECRET_KEY,
        true,
        algorithm: ALGORITHM
      ).first

      decoded.with_indifferent_access
    end
  end
end