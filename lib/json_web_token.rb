class JsonWebToken
  require 'active_support/hash_with_indifferent_access'

  SECRET_KEY = ENV['SECREt_KEY_BASE']

  def self.encode(payload, exp = 24.hours)
    payload['exp'] = exp.from_now.to_i
    JWT.encode(payload, SECRET_KEY)
  end


  def self.decode(token)
    decoded, = JWT.decode(token, SECRET_KEY)
    HashWithIndifferentAccess.new(decoded)
  rescue
    nil
  end
end 