class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def first_welcome(user, group, role, reset_pwd_url)
    @greeting = "Hi"
    @user = user
    @group = group
    @role = role
    @reset_pwd_url = reset_pwd_url

    mail to: user.email, subject: 'Vous avez été invité sur teamworkinteact'
  end
end
