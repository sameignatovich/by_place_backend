class ApplicationJwt
  class << self
    def encode(payload)
      data = { data: payload }
      JWT.encode data, Rails.application.credentials.jwt_secret!, 'HS256'
    end

    def decode(token)
      decoded_data = JWT.decode(token, Rails.application.credentials.jwt_secret!, true, algorithm: 'HS256')
      return decoded_data[0]['data']
    rescue
      nil
    end
  end
end