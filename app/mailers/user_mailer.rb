class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def approved_notification
    @user = params[:user]
    mail(to: @user.email, subject: 'Your Account has been approved!')
  end
end
