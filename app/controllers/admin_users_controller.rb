class AdminUsersController < ApplicationController
  def index
    @users = policy_scope(User)
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :user_type, :group)
  end
end
