# Keeps a record of every action moderators have taken
class ModeratorAction < ApplicationRecord
  belongs_to :moderator, class_name: "User"
  belongs_to :object, polymorphic: true
end
