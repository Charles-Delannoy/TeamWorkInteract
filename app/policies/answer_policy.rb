class AnswerPolicy < ApplicationPolicy
  def create?
    group ? ongoing_campaign? : false
  end

  def update?
    create?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def ongoing_campaign?
    group.campaigns.where('start_date <= ?', today).where('end_date >= ?', today)
  end

  def today
    Date.today
  end
end
