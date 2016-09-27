class User < ApplicationRecord
  has_many :project_users
  has_many :projects, through: :project_users

  devise :database_authenticatable, :omniauthable, :trackable

  def self.from_omniauth(auth)
   where(github_uid: auth.uid).first_or_create do |user|
     user.login = auth.info.nickname
     user.email = auth.info.email
     user.name = auth.info.name
     user.github_access_token = auth.credentials.token
     user.github_payload = auth
   end
  end
  
  def github_client
    @github_client ||= Octokit::Client.new(access_token: github_access_token)
  end
  
  def authenticatable_salt
    nil
  end
end
