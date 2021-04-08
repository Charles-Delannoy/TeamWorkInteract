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
    group && record == ongoing_survey || owner?(record)
  end

  def update?
    owner?(record)
  end

  def destroy?
    owner?(record)
  end

  private

  def ongoing_survey
    today = Date.today
    group.campaigns.where('start_date <= ?', today).where('end_date >= ?', today).first.survey
  end
end
