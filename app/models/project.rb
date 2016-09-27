class Project < ApplicationRecord
  has_many :project_users
  has_many :packages, dependent: :destroy
  
  validates_presence_of :name

  def source
    "https://www.npmjs.com/package/#{name}"
  end
  
  def check
    
  end
end
