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
    owner?(record)
  end

  def update?
    owner?(record)
  end

  def destroy?
    owner?(record)
  end
end
