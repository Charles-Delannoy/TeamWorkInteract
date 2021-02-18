class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :admin, inclusion: { in: %w[Y N] }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_groups
  # Groups
  has_many :groups
  has_many :project_groups, through: :user_groups, source: :group

  has_many :managed_users, through: :groups, source: :users
  has_one_attached :photo
end
