# Keeps a record of every action moderators have taken on a particular project
class ProjectStatusChange < ApplicationRecord
  belongs_to :moderator, class_name: "User"
  belongs_to :project
end
