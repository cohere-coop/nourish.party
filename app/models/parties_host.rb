# Links Parties to their Host Users
class PartiesHost < ApplicationRecord
  belongs_to :party
  belongs_to :host, class_name: :User
end
