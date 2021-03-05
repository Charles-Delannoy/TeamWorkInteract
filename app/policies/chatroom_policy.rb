class ChatroomPolicy < ApplicationPolicy

  def new?
    admin?
  end

  def show?
    record.users.where(id: user.id)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
