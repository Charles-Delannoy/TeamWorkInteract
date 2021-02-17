class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if current_user
      redirect_to edit_validate_accounts_path if current_user.first_name.nil? && current_user.last_name.nil?
    else
      redirect_to dashboard_path
    end
  end
end
