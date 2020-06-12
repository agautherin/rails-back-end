class Chatroom < ApplicationRecord
    has_many :user, through: :messages
    has_many :messages, dependent: :destroy

end
