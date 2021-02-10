class Campaign < ApplicationRecord
  belongs_to :survey
  has_many :groups, through: :group_campaigns
end
