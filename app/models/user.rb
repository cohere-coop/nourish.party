# User model to represent an actual user
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :party_hosting_requests_hosts, foreign_key: :host_id
  has_many :party_hosting_requests, through: :party_hosting_requests_hosts
end
