class DashboardsController < ApplicationController
  skip_after_action :verify_authorized

  def show
    @groups = current_user.groups unless current_user.admin
  end
end
