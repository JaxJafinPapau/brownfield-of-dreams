class EmailActivationMailer < ApplicationMailer
  def activation(user)
    @user = user
    mail(to: user.email, subject: "#{user.first_name}, please activate your account!")
  end
end
