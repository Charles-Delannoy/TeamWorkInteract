class UserMailer < ApplicationMailer

  def welcome(user, url)
    @user = user
    @url = url
    mail to: user.email, subject: 'TWI : Votre compte a bien été créé'
  end

  def first_welcome(user, group, role, reset_pwd_url)
    @user = user
    @group = group
    @role = role
    @reset_pwd_url = reset_pwd_url

    mail to: user.email, subject: 'Vous avez été invité sur teamworkinteact'
  end

  def welcome_to_group(user, group, role)
    @greeting = "Hi"
    @user = user
    @group = group
    @role = role

    mail to: user.email, subject: 'Teamworkinteact : vous avez été invité à un groupe'
  end
end
