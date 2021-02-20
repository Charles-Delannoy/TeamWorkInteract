class Answer < ApplicationRecord
  belongs_to :proposition
  belongs_to :user
  belongs_to :group_campaign
end
