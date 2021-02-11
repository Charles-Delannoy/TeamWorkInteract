class Question < ApplicationRecord
  belongs_to :axe
  belongs_to :survey

  has_many :propositions, dependent: :destroy

  accepts_nested_attributes_for :propositions
end
