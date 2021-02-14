class GroupCampaignPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    admin?
  end

  def destroy?
    owner?(record.campaign.survey)
  end
end
