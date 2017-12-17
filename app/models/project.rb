# Represents a Project in the database
class Project < ApplicationRecord
  has_many :projects_users
  has_many :users, through: :projects_users
end
