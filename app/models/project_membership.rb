# Links {Projects} to a {RegisteredUser}
class ProjectMembership < ApplicationRecord
  belongs_to :project
  belongs_to :member, class_name: "RegisteredUser"
end
