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

    members.each do |member|
      ProjectStatusChangeMailer.approved(member: member, approval: approval).deliver
    end
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

    members.each do |member|
      ProjectStatusChangeMailer.rejected(member: member, rejection: rejection).deliver
    end
    true
  end

  def rejected?
    status == "rejected"
  end

  def apply_status_change(status_change, status:)
    status_change.project = self
    transaction { status_change.save && update(status: status) }
  end
end
