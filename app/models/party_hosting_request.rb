# Represents a request to host a party made by a host or group of hosts.  Hosting requests may be approved by
# an InstanceAdmin which will allow them to begin receiving money.
class PartyHostingRequest < ApplicationRecord
  has_many :party_hosting_requests_hosts
  has_many :hosts, through: :party_hosting_requests_hosts
  has_one :resulting_party, class_name: :Party, foreign_key: :from_party_hosting_request_id

  def approve
    return false if resulting_party.present?
    create_resulting_party(title: title, summary: summary)
    hosts.each do |host|
      resulting_party.hosts << host
    end
    archive
  end

  def archive
    update(status: :archived)
  end

  def archived?
    status.to_sym == :archived
  end
end
