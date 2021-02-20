class DashboardsController < ApplicationController
  skip_after_action :verify_authorized

  def show
    redirect_to admin_dashboard_path if admin?
    @groups = current_user.groups
  end

  private

  def admin?
    current_user.admin == 'Y'
  end
end
