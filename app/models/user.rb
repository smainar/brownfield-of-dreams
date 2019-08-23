class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, :on => :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def update_github_oauth(auth_hash)
    self.github_id = auth_hash['uid']
    self.github_handle = auth_hash['info']['nickname']
    self.github_token = auth_hash['credentials']['token']
    self.github_url = auth_hash['info']['urls']["GitHub"]
    save!
  end

end
