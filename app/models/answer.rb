class Answer < ApplicationRecord
  belongs_to :proposition
  belongs_to :user
  belongs_to :group_campaign
  has_one :group, through: :group_campaign
end
