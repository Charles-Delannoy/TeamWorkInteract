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
    owner?(record)
  end

  def update?
    owner?(record)
  end

  def destroy?
    owner?(record)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
