class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    owner?(record.survey)
  end

  def create?
    admin?
  end

  def update?
    owner?(record.survey)
  end

  def destroy?
    owner?(record.survey)
  end
end
