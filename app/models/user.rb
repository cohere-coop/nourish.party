# User model to represent an actual user
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :project_memberships, foreign_key: :member_id
  has_many :projects, through: :project_memberships
  has_many :project_status_changes, foreign_key: :moderator_id

  def registered?
    new_record?
  end
end
