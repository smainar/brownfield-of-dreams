class Invite

  def initialize(current_user, invitee_github_handle)
    @current_user           = current_user
    @invitee_github_handle  = invitee_github_handle
  end

  def invite_user
    #Get the handle for inviter
    #Get inviter info
    #Get invitee info
    #send invite email through usermailer with both handles and the invitees email
    #add a flash message
    #search for missing email
    GithubService.new(@current_user.github_token)
  end

  private
  attr_reader :curent_user,
              :invitee_github_handle
end
