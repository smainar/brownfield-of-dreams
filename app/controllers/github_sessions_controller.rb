class GithubSessionsController < ApplicationController
  def create
    user = User.find_or_create_by(github_id: auth_hash[:uid]) do |user|
      user.handle = auth_hash[:info][:nickname]
      user.github_token = auth_hash[:credentials][:token]
      user.github_id =  auth_hash[:uid]
    end

    sessions[:user_id] = user.id
    redirect_to '/dashboard'

    # def create
    #   auth = request.env["omniauth.auth"]
    #   user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    #   session[:user_id] = user.id
    #   redirect_to root_url, :notice => "Signed in!"
  end

protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
