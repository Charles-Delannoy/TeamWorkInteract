class CampaignPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    admin?
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
