# Links ProjectRequests to Users
class ProjectRequestsUser < ApplicationRecord
  belongs_to :project_request
  belongs_to :user
end
