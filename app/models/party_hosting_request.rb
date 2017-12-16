class PartyHostingRequest < ApplicationRecord
  has_many :party_hosting_request_hosts
  has_many :hosts, through: :party_hosting_request_hosts
  has_one :resulting_party, class_name: :Party, foreign_key: :from_party_hosting_request_id

  def approve
    return false if resulting_party.present?
    create_resulting_party(title: title, activity: activity)
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
