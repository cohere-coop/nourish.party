class CreateParties < ActiveRecord::Migration[5.1]
  def change
    create_table :parties, id: :uuid do |t|
      t.string :title
      t.string :summary
      t.uuid :from_party_hosting_request_id

      t.timestamps
    end

    create_table :parties_hosts, id: :uuid do |t|
      t.uuid :host_id
      t.uuid :party_id

      t.timestamps
    end

    create_table :party_hosting_requests, id: :uuid do |t|
      t.string :title
      t.string :summary
      t.string :status

      t.timestamps
    end

    create_table :party_hosting_requests_hosts, id: :uuid do |t|
      t.uuid :host_id
      t.uuid :party_hosting_request_id

      t.timestamps
    end
  end
end
