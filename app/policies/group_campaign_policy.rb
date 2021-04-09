class GroupCampaignPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    survey_owner? || record.campaign == ongoing_campaign
  end

  def create?
    admin?
  end

  def destroy?
    survey_owner?
  end

  private

  def survey_owner?
    owner?(record.campaign.survey)
  end

  def ongoing_campaign
    today = Date.today
    group.campaigns.where('start_date <= ?', today).where('end_date >= ?', today).first
  end
end
