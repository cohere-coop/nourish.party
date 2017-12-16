# Represents a Party in the database
class Party < ApplicationRecord
  has_many :parties_hosts
  has_many :hosts, through: :parties_hosts
end
