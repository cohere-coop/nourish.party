# Keeps a record of every action moderators have taken on a particular project
class ProjectStatusChange < ApplicationRecord
  belongs_to :moderator, class_name: "RegisteredUser"
  belongs_to :project

  scope :approved, -> { where(action: "approved") }
  scope :rejected, -> { where(action: "rejected") }

  def self.latest
    order(created_at: :desc).first
  end
end
