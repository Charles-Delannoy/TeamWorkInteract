class AccessGroupsController < ApplicationController
  skip_after_action :verify_authorized, only: :update

  def update
    @group = Group.find(params[:group].to_i)
    session[:group] = @group
    redirect_to dashboard_path
  end
end
