# Represents a Project in the database
class Project < ApplicationRecord
  has_many :project_memberships
  has_many :members, through: :project_memberships
  scope :approved, -> { where(status: "approved") }

  def approve
    return true if approved?
    update(status: "approved")
  end

  def approved?
    status == "approved"
  end

  def pending?
    status == "pending"
  end
end
