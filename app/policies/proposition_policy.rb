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
    owner?(record.question.survey)
  end

  def destroy?
    owner?(record.question.survey)
  end
end
