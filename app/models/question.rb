class Question < ApplicationRecord
  belongs_to :axe
  belongs_to :survey

  has_many :propositions, inverse_of: :question, dependent: :destroy

  accepts_nested_attributes_for :propositions
end
