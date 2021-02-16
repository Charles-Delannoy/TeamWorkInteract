class DashboardsController < ApplicationController
  skip_after_action :verify_authorized

  def show
    @groups = current_user.groups unless admin?

  end

  private

  def admin?
    current_user.admin == 'Y'
  end
end
