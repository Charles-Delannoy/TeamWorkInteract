class CampaignPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.includes(:survey).where(surveys: { user: user })
    end
  end

  def index?
    admin?
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
