class Group < ApplicationRecord
  belongs_to :user
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :group_campaigns
  has_many :campaigns, through: :group_campaigns

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :start_date, presence: true
  validates :end_date, presence: true

  include StartBeforeEndConcern
end
