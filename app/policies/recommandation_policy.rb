class RecommandationPolicy < ApplicationPolicy

  def new?
    admin?
  end

  def create?
    record.axe.user = user
  end

  def edit?
    record.axe.user = user
  end

  def update?
    record.axe.user = user
  end

  def destroy?
    record.axe.user = user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
