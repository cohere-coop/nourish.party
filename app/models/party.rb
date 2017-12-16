class Party < ApplicationRecord
  has_many :party_hosts
  has_many :hosts, through: :party_hosts
end
