class UserMailer < ActionMailer::Base
  default :from => "no-reply@brownfield.io"

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Registration Confirmation")
  end

  def github_invite(user, email)
    @user = user
    mail(:to => email, :subject => "#{user.first_name} invites you to join his app!")
  end

end
