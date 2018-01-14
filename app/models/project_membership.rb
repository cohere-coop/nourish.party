# Links {Projects} to a {RegisteredUser}
class ProjectMembership < ApplicationRecord
  belongs_to :project
  belongs_to :member, class_name: :RegisteredUser

  # eventually this should be something like `has_one :payment_processor_connection`
  has_many :stripe_connections, through: :member
end
