# User model to represent an actual user
class RegisteredUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :lockable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :project_memberships, foreign_key: :member_id
  has_many :projects, through: :project_memberships
  has_many :project_status_changes, foreign_key: :moderator_id
  has_many :stripe_connections, foreign_key: :owner_id
  has_many :slack_teams, foreign_key: :owner_id
  has_many :oauth_applications, class_name: "Doorkeeper::Application", as: :owner

  def registered?
    persisted?
  end
end
