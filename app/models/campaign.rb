class Campaign < ApplicationRecord
  belongs_to :survey
  has_many :group_campaigns, dependent: :destroy
  has_many :groups, through: :group_campaigns

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_before_end

  private

  def start_before_end
    errors.add :end_date, "must be after starts_at" if start_date && end_date && end_date <= start_date
  end
end
