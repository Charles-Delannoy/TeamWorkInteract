class SurveyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def index?
    admin?
  end

  def create?
    admin?
  end

  def show?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end
end
