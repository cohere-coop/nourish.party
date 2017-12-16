class PartyHostingRequestHost < ApplicationRecord
  belongs_to :party_hosting_request
  belongs_to :host, class_name: :User
end
