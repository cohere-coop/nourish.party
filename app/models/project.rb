# Represents a Project in the database
class Project < ApplicationRecord
  has_many :project_status_changes

  has_many :project_memberships
  has_many :members, through: :project_memberships
  scope :approved, -> { where(status: "approved") }
  scope :pending, -> { where(status: "pending") }
  scope :rejected, -> { where(status: "rejected") }

  def approve(approval:)
    return true if approved?
    return false unless apply_status_change(approval, status: "approved")
    notify_members_of_status_change(approval)
    true
  end

  def approved?
    status == "approved"
  end

  def pending?
    status == "pending"
  end

  def reject(rejection:)
    return true if rejected?
    return false unless apply_status_change(rejection, status: "rejected")
    notify_members_of_status_change(rejection)
    true
  end

  def rejected?
    status == "rejected"
  end

  private def apply_status_change(status_change, status:)
    status_change.project = self
    transaction { status_change.save && update(status: status) }
  end

  private def notify_members_of_status_change(status_change)
    members.each do |member|
      ProjectStatusChangeMailer
        .status_change_notification(member: member, status_change: status_change)
        .deliver
    end
  end
end
