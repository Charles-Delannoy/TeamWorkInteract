class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :send_welcome_email, if: :admin?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include PgSearch::Model

  has_many :user_groups
  # Groups
  has_many :groups
  has_many :project_groups, through: :user_groups, source: :group

  has_many :managed_users, through: :groups, source: :users
  has_one_attached :photo

  pg_search_scope :search_by_first_last_name_and_email,
                  against: %i[first_name last_name email],

                  using: {
                    tsearch: { prefix: true }
                  }



  def full_name
    return first_name.nil? || last_name.nil? ? nil : "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def completion_rate(group_campaign)
    n_questions = group_campaign.survey.questions.count
    n_answers = Answer.where(group_campaign: group_campaign, user: self).count
    n_answers * 100 / n_questions
  end

  private

  def admin?
    admin
  end

  def send_welcome_email
    http = Rails.env.development? ? '' : "https://"
    port = Rails.env.development? ? ':3000' : ""
    base_url = ActionMailer::Base.default_url_options[:host]
    url = "#{http}#{base_url}#{port}"
    UserMailer.welcome(self, url).deliver_later
  end
end
