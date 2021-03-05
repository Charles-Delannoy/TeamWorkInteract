class MessagePolicy < ApplicationPolicy

  def create?
    record.chatroom.users.include?(user)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
