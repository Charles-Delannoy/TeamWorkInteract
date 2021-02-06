class UserGroup < ApplicationRecord
  validates :user_type, inclusion: { in: %w(R M), message: 'Doit être Référent ou membre' }
  belongs_to :user
  belongs_to :group
end
