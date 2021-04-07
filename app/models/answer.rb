class Answer < ApplicationRecord
  belongs_to :proposition
  has_one :question, through: :proposition
  has_one :axe, through: :question
  belongs_to :user
  belongs_to :group_campaign
  has_one :group, through: :group_campaign
end
