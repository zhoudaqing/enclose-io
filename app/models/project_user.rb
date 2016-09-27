class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user

  after_create do
    project.check if project.reload.project_users.count > 1
  end
  
  after_destroy do
    project.destroy if 0 == project.reload.project_users.count
  end
end
