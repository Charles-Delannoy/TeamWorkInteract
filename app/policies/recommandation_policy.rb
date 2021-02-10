class RecommandationPolicy < ApplicationPolicy

  def new?
    admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
