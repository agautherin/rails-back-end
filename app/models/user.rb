class User < ApplicationRecord
    has_many :messages
    has_many :groups
    
    has_many :active_relationships, class_name: "Group", foreign_key: :friender_id, dependent: :destroy
    has_many :friendees, through: :active_relationships, source: :friendee
    has_many :passive_relationships, class_name: "Group", foreign_key: :friendee_id, dependent: :destroy
    has_many :frienders, through: :passive_relationships, source: :friender
    

    def self.check_user(credentials)
        @user = self.find_by(username: credentials[:username])
        # byebug
        if @user == nil 
            return nil
        end    
        if @user[:password] == credentials[:password] 
            return @user
        else
            return false
        end
        
    end
    
    def grant_token

        issued = Time.now.to_i
        expiration_delay = Time.now.to_i + 2 * 3600 # expiration after 3600s (times) hours

        payload = {
            username: self[:username],
            sub: "user_super_secret_id#{self[:id]}",
            iat: issued,
            exp: expiration_delay
                    } 
        # byebug
        token = JWT.encode payload, $secretkey, 'HS256', { typ: 'JWT'}
        return token

        
    end
end
