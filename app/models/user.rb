class User < ApplicationRecord
    has_secure_password

    validates :username, presence: true, uniqueness: true
    validates :password, presence: true, length: {minimum: 6}

    has_many :messages
    has_many :groups
    
    has_many :active_relationships, class_name: "Group", foreign_key: :friender_id, dependent: :destroy
    has_many :friendees, through: :active_relationships, source: :friendee
    has_many :passive_relationships, class_name: "Group", foreign_key: :friendee_id, dependent: :destroy
    has_many :frienders, through: :passive_relationships, source: :friender
    

    def self.check_user(credentials)
        
        @user = self.find_by(username: credentials[:username]).try(:authenticate, credentials[:password])
           
        
    end
    
    def self.encode(user)
        
        issued = Time.now.to_i
        expiration_delay = Time.now.to_i + 2 * 3600 # expiration after 3600s (times) hours
    
        payload = {
          username: user[:username],
          sub: user[:id],
          iat: issued,
          exp: expiration_delay
                  } 
        
        token = JWT.encode payload, 'secret_key', 'HS256', { typ: 'JWT'}
        return token
      end
    
      def self.decode(token)
        decoded = JWT.decode(token, 'secret_key')[0]
        HashWithIndifferentAccess.new decoded
      end


end
