class JsonWebToken
    
  def self.encode(user)

    issued = Time.now.to_i
    expiration_delay = Time.now.to_i + 2 * 3600 # expiration after 3600s (times) hours

    payload = {
      username: user[:username],
      sub: user[:id],
      iat: issued,
      exp: expiration_delay
              } 
              
    token = JWT.encode payload, $secretkey, 'HS256', { typ: 'JWT'}
    return token
  end

  def self.decode(token)
    decoded = JWT.decode(token, $secretkey)[0]
    HashWithIndifferentAccess.new decoded
  end
end