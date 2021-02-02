class SurveyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.user_type == "A"
  end

  def show?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user    
  end
end
