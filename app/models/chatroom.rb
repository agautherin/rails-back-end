class Chatroom < ApplicationRecord
    has_many :users, through: :messages
    has_many :messages, dependent: :destroy

end
