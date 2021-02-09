class Question < ApplicationRecord
  belongs_to :axe
  belongs_to :survey

  has_many :propositions, dependent: :destroy
end
