class Project < ApplicationRecord
  has_many :project_users
  has_many :packages
  
  validates_presence_of :name
end
