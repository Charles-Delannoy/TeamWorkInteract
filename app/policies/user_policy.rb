class UserPolicy < ApplicationPolicy

  def index?
    admin?
  end

  def new?
    admin?
  end

  class Scope < Scope
    def resolve
      scope.includes(:user_groups).includes(:groups).where(groups: {user: user})
    end
  end
end
