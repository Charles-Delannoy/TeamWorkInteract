class RecommandationPolicy < ApplicationPolicy

  def create?
    admin?
  end

  def update?
    owner?(record.axe)
  end

  def destroy?
    owner?(record.axe)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
