# Links PartyHostingRequests to Users so we know who would be hosts of the party
class PartyHostingRequestsHost < ApplicationRecord
  belongs_to :party_hosting_request
  belongs_to :host, class_name: :User
end
