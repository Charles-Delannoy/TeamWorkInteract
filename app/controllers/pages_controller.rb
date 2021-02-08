class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    redirect_to dashboard_path if current_user && (current_user.first_name && current_user.last_name)
    redirect_to validation_path if current_user && !(current_user.first_name && current_user.last_name)
  end

  def dashboard
  end

  def validate_account
    current_user.last_name = user_params[:last_name]
    current_user.first_name = user_params[:first_name]
    current_user.save ? redirect_to(root_path) : (render :new)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
