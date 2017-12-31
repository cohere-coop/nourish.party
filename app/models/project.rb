# Represents a Project in the database
class Project < ApplicationRecord
  has_many :project_status_changes

  has_many :project_memberships
  has_many :members, through: :project_memberships
  scope :approved, -> { where(status: "approved") }
  scope :pending, -> { where(status: "pending") }

  def approve
    return true if approved?
    update(status: "approved")
  end

  def reject
    return true if rejected?
    update(status: "rejected")
  end

  def approved?
    status == "approved"
  end

  def rejected?
    status == "rejected"
  end

  def pending?
    status == "pending"
  end
end
