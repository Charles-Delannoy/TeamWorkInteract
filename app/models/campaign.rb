class Campaign < ApplicationRecord
  belongs_to :survey
  has_many :group_campaigns, dependent: :destroy
  has_many :groups, through: :group_campaigns
end
