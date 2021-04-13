class Axe < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :recommandations

  validates :title, presence: true, length: { minimum: 3 }, uniqueness: { scope: :user }
  validates :description, presence: true, length: { minimum: 10 }
end
