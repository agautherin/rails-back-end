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
    
end
