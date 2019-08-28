class InvitesController < ApplicationController
  def new

  end

  def create
    binding.pry
    invitee_github_hanlde = params[:github_handle]
    send_invite = Invite.new(current_user, invitee_github_handle)
    send_invite.invite_user
    # flash[success:] = "Successfully sent invite!"
    redirect_to dashboard_path
  end
end
