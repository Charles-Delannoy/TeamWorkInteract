class UserContext
  attr_reader :user, :group

  def initialize(user, session)
    @user = user
    @group = session[:group] ? Group.find(session[:group]['id']) : nil
  end
end
