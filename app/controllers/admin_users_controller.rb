class AdminUsersController < ApplicationController
  def index
    @users = policy_scope(User).order(:first_name).uniq
    new
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
    @group = Group.find(user_group_params[:groups].to_i)
    @existing_user = User.where(email: user_params[:email])[0]
    @role = user_group_params[:role] == "R" ? 'référent' : 'membre'
    if @existing_user
      add_user_to_group
    else
      create_user
    end
  end

  private

  def create_user
    @user = User.new(user_params)
    if @user.save
      create_user_group(@user)
      redirect_to admin_users_path
      raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
      @user.reset_password_token = hashed
      @user.reset_password_sent_at = Time.now.utc
      @user.save
      http = Rails.env.development? ? '' : "https://"
      port = Rails.env.development? ? ':3000' : ""
      base_url = ActionMailer::Base.default_url_options[:host]
      reset_pwd_url = "#{http}#{base_url}#{port}/users/password/edit?reset_password_token=#{raw}"

      UserMailer.first_welcome(@user, @group.name, @role, reset_pwd_url).deliver_later
    else
      @users = policy_scope(User)
      render :index
    end
  end

  def add_user_to_group
    if UserGroup.where(user: @existing_user, group: @group).empty?
      create_user_group(@existing_user)
      UserMailer.welcome_to_group(@existing_user, @group.name, @role).deliver_later
      flash.alert = "Cet utilisateur a été ajouté au groupe"
    else
      flash.alert = "Cet utilisateur fait déjà partie de ce groupe"
    end
    redirect_to admin_users_path
  end

  def create_user_group(user)
    @user_group = UserGroup.create(user: user, group: @group, role: user_group_params[:role])
  end

  def user_params
    params.require(:user).permit(:email, :admin, :password, :encrypted_password)
  end

  def user_group_params
    params.require(:user).permit(:groups, :role)
  end
end
