class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def self.create_with_omniauth(auth_hash)

    create! do |user|
      binding.pry
      user.provider = auth_hash["provider"]
      user.uid = auth_hash["uid"]
      user.name = auth_hash["info"]["nickname"]
    end
  end

  # def create_or_find_github_user(auth_hash)
  #   binding.pry
  #   create! do |user|
  #     binding.pry
  #     user.provider = auth_hash["provider"]
  #     user.uid = auth_hash["uid"]
  #     user.name = auth_hash["info"]["nickname"]
  #   end
  # end


end
