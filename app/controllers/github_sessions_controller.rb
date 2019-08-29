# frozen_string_literal: true

class GithubSessionsController < ApplicationController
  def create
    current_user.update_github_oauth(auth_hash)
    redirect_to dashboard_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
