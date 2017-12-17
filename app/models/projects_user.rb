# Links Projects to a User
class ProjectsUser < ApplicationRecord
  belongs_to :project
  belongs_to :user
end
