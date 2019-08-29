# frozen_string_literal: true

class ActivateAccountController < ApplicationController
  def create
    user = User.find(params[:user_id])
    user.update(active: true)
    binding.pry
    flash[:success] = 'Thank you! Your account is now activated.'
    redirect_to dashboard_path
  end
end
