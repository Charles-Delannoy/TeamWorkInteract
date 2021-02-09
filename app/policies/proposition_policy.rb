class PropositionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    admin?
  end

  def update?
    record.question.survey.user == user
  end

  def destroy?
    record.question.survey.user == user
  end
end
