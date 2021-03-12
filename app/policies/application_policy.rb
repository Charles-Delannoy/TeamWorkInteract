class ApplicationPolicy
  attr_reader :context, :user, :record, :group

  def initialize(context, record)
    @context = context
    @record = record
  end

  delegate :user, to: :context
  delegate :group, to: :context

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope, :context

    def initialize(context, scope)
      @context = context
      @scope = scope
    end

    delegate :user, to: :context

    def resolve
      scope.all
    end
  end

  private

  def owner?(element)
    element.user == user
  end

  def admin?
    user.admin
  end
end
