class User < ApplicationRecord
    has_many :messages
    has_many :groups

    has_many :active_relationships, class_name: "Group", foreign_key: :friender_id, dependent: :destroy
    has_many :friendees, through: :active_relationships, source: :friendee
    has_many :passive_relationships, class_name: "Group", foreign_key: :friendee_id, dependent: :destroy
    has_many :frienders, through: :passive_relationships, source: :friender

end
