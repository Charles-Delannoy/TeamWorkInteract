class Recommandation < ApplicationRecord
  belongs_to :axe
  validates :description, length: { minimum: 10 }
end
