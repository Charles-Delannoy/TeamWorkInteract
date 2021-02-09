class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    record.survey.user == user
  end

  def create?
    admin?
  end

  def update?
    record.survey.user == user
  end

  def destroy?
    record.survey.user == user
  end
end
