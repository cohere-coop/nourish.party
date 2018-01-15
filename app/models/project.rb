# Represents a Project in the database
class Project < ApplicationRecord
  class AmbiguousStripeConnection < StandardError; end

  has_many :project_status_changes

  has_many :project_memberships
  has_many :members, through: :project_memberships
  has_many :stripe_connections, through: :project_memberships
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

  def resubmitted?
    previous_changes.fetch("status", []) == %w[rejected pending]
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

  def stripe_account_id
    stripe_connection.stripe_account_id
  end

  def taking_payments?
    approved? && stripe_connection.present?
  rescue AmbigousStripeConnection
    false
  end

  def stripe_connection
    raise AmbiguousStripeConnection if project_memberships.count > 1
    raise AmbiguousStripeConnection if stripe_connections.count > 1
    stripe_connections.first
  end
end
