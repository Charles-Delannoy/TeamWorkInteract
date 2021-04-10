class SendFirstWelcomeMailJob < ApplicationJob
  queue_as :default

  def perform(user, group, role)
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    user.reset_password_token = hashed
    user.reset_password_sent_at = Time.now.utc
    user.save
    http = Rails.env.development? ? '' : "https://"
    port = Rails.env.development? ? ':3000' : ""
    base_url = ActionMailer::Base.default_url_options[:host]
    reset_pwd_url = "#{http}#{base_url}#{port}/users/password/edit?reset_password_token=#{raw}"

    UserMailer.first_welcome(user, group.name, role, reset_pwd_url).deliver_later
  end
end
