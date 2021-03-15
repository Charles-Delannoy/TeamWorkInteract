class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :set_admin
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
                  against: [:first_name, :last_name, :email],

                  using: {
                    tsearch: { prefix: true }
                  }

  def set_admin
    admin = admin == 'Y'
  end

  def full_name
    return first_name.nil? || last_name.nil? ? nil : "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
