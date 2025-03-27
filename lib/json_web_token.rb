class JsonWebToken
  SECRET_KEY = ENV['SECREt_KEY_BASE']

  def self.encode(payload, exp = 24.hours)
    payload['exp'] = exp.from_now.to_i
    JWT.encode(payload, SECRET_KEY)
  end


  def self.decode(token)
    JWT.decode(token, SECRET_KEY, true, { :algorithm => algorithm }).first
  rescue
    nil
  end
end 