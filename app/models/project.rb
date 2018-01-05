# Represents a Project in the database
class Project < ApplicationRecord
  has_many :project_status_changes

  has_many :project_memberships
  has_many :members, through: :project_memberships
  scope :approved, -> { where(status: "approved") }
  scope :pending, -> { where(status: "pending") }
  scope :rejected, -> { where(status: "rejected") }

  def approved?
    status == "approved"
  end

  def pending?
    status == "pending"
  end

  def rejected?
    status == "rejected"
  end

  def apply_status_change(status_change)
    return true if status == status_change.action
    status_change.project = self
    return false unless transaction { status_change.save && update(status: status_change.action) }
    notify_members_of_status_change(status_change)
    true
  end

  private def notify_members_of_status_change(status_change)
    members.each do |member|
      ProjectStatusChangeMailer
        .status_change_notification(member: member, status_change: status_change)
        .deliver
    end
  end
end
