# Represents a request to user a project made by a user or group of users.  Hosting requests may be approved
# by an InstanceAdmin which will allow them to begin receiving money.
class ProjectRequest < ApplicationRecord
  has_many :project_requests_users
  has_many :users, through: :project_requests_users
  has_one :resulting_project, class_name: :Project, foreign_key: :from_project_request_id

  def approve
    return false if resulting_project.present?
    create_resulting_project(title: title, summary: summary)
    users.each do |user|
      resulting_project.users << user
    end
    archive
  end

  def archive
    update(status: :archived)
  end

  def archived?
    status.to_sym == :archived
  end
end
