class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if current_user && valid_account?
      redirect_to admin? ? admin_dashboard_path : dashboard_path
    end
    redirect_to edit_validate_accounts_path if current_user && !valid_account?
  end

  private

  def valid_account?
    !current_user.first_name.nil? && !current_user.last_name.nil?
  end

  def admin?
    current_user.admin == true
  end
end
