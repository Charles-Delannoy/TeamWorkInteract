class GroupPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def create?
    admin?
  end

  def new?
    admin?
  end

  def edit?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
