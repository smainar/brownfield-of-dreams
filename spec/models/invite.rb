class Invite

  def initialize(current_user, invitee_handle)
    @current_user = current_user
    @invitee_github_handle = invitee_handle
  end

  def invite_user

  end

  private
  attr_reader :curent_user,
              :invitee_github_handle
end
