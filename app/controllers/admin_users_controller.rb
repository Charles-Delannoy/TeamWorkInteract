class AdminUsersController < ApplicationController
  def index
    @users = policy_scope(User)
  end

  def new
    alphabet = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
    pwd = ''
    6.times do
      pwd += alphabet.sample
    end
    @user = User.new
    @pwd = pwd
    authorize @user
  end

  def create
    @group = Group.find(group_id[:groups].to_i)
    @existing_user = User.where(email: user_params[:email])
    if @existing_user.empty?
      @user = User.new(user_params)
      if @user.save
        @user_group = UserGroup.create(user: @user, group: @group)
        redirect_to admin_users_path
      else
        render :new
      end
    else
      if UserGroup.where(user: @existing_user, group: @group).empty?
        UserGroup.create(user: @user, group: @group)
        flash.alert = "Cet utilisateur a été ajouté au groupe"
      else
        flash.alert = "Cet utilisateur fait déjà partie de ce groupe"
      end
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :user_type, :password, :password_confirmation, :encrypted_password)
  end

  def group_id
    params.require(:user).permit(:groups)
  end
end
