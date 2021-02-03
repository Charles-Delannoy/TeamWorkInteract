class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :user_type, inclusion: {in: %w(A R M), message: 'doit être Admin, Référent ou membre'}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
