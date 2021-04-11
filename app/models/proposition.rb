class Proposition < ApplicationRecord
  belongs_to :question
  has_many :answers

  validates :title, presence: true, length: { minimum: 3 }
  validates :value, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end
