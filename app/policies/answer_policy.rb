class AnswerPolicy < ApplicationPolicy
  def create?
    group && member? ? ongoing_campaign? : false
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

  def member?
    UserGroup.where(group: group, user: user).first.role == 'M'
  end

  def today
    Date.today
  end
end
