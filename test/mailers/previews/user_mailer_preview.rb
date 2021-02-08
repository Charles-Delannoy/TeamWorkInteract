# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/first_welcome
  def first_welcome
    user = User.first
    group = Group.first.name
    role = 'référent'
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    user.reset_password_token = hashed
    user.reset_password_sent_at = Time.now.utc
    user.save
    reset_pwd_url = "http://localhost:3000/users/password/edit?reset_password_token=#{raw}"
    UserMailer.first_welcome(user, group, role, reset_pwd_url)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_to_group
  def welcome_to_group
    user = User.last
    group = Group.first.name
    role = 'référent'

    UserMailer.welcome_to_group(user, group, role)
  end

end
