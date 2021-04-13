class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions, inverse_of: :survey, dependent: :destroy
  has_many :propositions, through: :questions
  has_many :axes, through: :questions

  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true, length: { minimum: 3 }, uniqueness: { scope: :user }
  validates :description, presence: true, length: { minimum: 10 }
end
