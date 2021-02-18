class UserPolicy < ApplicationPolicy

  def index?
    admin?
  end

  def new?
    admin?
  end

  class Scope < Scope
    def resolve
      user.managed_users
    end
  end
end
