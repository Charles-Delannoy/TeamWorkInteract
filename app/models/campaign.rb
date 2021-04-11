class Campaign < ApplicationRecord
  belongs_to :survey
  has_many :group_campaigns, dependent: :destroy
  has_many :groups, through: :group_campaigns

  validates :title, presence: true, length: { minimum: 4 }
  validates :start_date, presence: true
  validates :end_date, presence: true

  include StartBeforeEndConcern
end
