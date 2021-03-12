class DashboardsController < ApplicationController
  skip_after_action :verify_authorized

  def show
    redirect_to admin_dashboard_path if admin?
    @groups = current_user.project_groups
    @chatrooms = Chatroom.includes(:chatroom_users).where(chatroom_users: { user: current_user })
  end

  private

  def admin?
    current_user.admin
  end
end
