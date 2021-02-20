class ValidateAccountsController < ApplicationController
  skip_after_action :verify_authorized

  def update
    current_user.last_name = validate_account_params[:last_name]
    current_user.first_name = validate_account_params[:first_name]
    current_user.save ? redirect_to(root_path) : (render :new)
  end

  private

  def validate_account_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
