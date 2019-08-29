class InvitesController < ApplicationController
  def new

  end

  def create
    if invitee.nil?
      flash[:error] = "Github user not found!"
    elsif invitee_email.nil?
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    else
      flash[:success] = "Successfully sent invite!"
      UserMailer.invite(invitee, inviter, invitee_email).deliver_now
    end
      redirect_to dashboard_path
  end

  private
    def invitee_email
      GithubFindService.new(current_user, params[:github_handle]).find_email_by_handle
    end

    def inviter
      current_user.github_handle
    end

    def invitee
      GithubFindService.new(current_user, params[:github_handle]).find_invitee
    end

end
