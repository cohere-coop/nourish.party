class PartyHost < ApplicationRecord
  belongs_to :party
  belongs_to :host, class_name: :User
end
