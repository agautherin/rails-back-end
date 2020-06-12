class Group < ApplicationRecord
    belongs_to :friendee, class_name: "User", foreign_key: :friendee_id
    belongs_to :friender, class_name: "User", foreign_key: :friender_id
end
