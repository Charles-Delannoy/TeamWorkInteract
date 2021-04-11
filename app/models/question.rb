class Question < ApplicationRecord
  belongs_to :axe
  belongs_to :survey

  has_many :propositions, inverse_of: :question, dependent: :destroy
  has_many :answers, through: :propositions

  accepts_nested_attributes_for :propositions

  validates :title, presence: true, length: {minimum: 3}
  validates :coef, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end
