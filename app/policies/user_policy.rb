class UserPolicy < ApplicationPolicy

  def index?
    admin?
  end

  def new?
    admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
