class InvitesController < ApplicationController
  def new

  end

  def create
    invitee_github_handle = params[:github_handle]
    send_invite = Invite.new(current_user, invitee_github_handle)
    send_invite.invite_user
    redirect_to dashboard_path
  end
end
