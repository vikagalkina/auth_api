class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  ALGORITHM = 'HS256'

  class << self
    def encode(payload, exp: 1.week.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY, ALGORITHM)
    end

    def decode(token)
      decoded = JWT.decode(token, SECRET_KEY, true, algorithm: ALGORITHM)[0]
      HashWithIndifferentAccess.new decoded
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError => e
      Rails.logger.error e
      nil
    end
  end
end