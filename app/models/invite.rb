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
    invitee_info = GithubService.new(@invitee_github_handle)
    inviter_info = GithubService.new(@current_user)

binding.pry
    ActionMailer.send_invite(inviter_handle)
  end

  private
  attr_reader :curent_user,
              :invitee_github_handle
end
