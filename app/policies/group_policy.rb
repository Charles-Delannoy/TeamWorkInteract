class GroupPolicy < ApplicationPolicy
  def create?
    admin?
  end

  def new?
    admin?
  end

  def edit?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def owner?
    record.user == user
  end

  def admin?
    user.user_type == 'A'
  end
end
