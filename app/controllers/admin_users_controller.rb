class AdminUsersController < ApplicationController
  def index
    users_filtered
    new
    prepare_search_bar
    @chatrooms = Chatroom.includes(:chatroom_users).where(chatroom_users: { user: current_user })
    render :index if params.keys.length > 2
  end

  def new
    generate_pswd
    @user = User.new
    authorize @user
  end

  def create
    @group = user_group_params[:groups].to_i.zero? ? nil : Group.find(user_group_params[:groups].to_i)
    @existing_user = User.where(email: user_params[:email])[0]
    get_role
    if @group && @role
      @existing_user ? add_user_to_group : create_user
    else
      flash[:alert] = []
      flash[:alert] << "⚠ Vous devez selectionner un groupe" if @group.nil?
      flash[:alert] << "⚠ Vous devez selectionner un role" if @role.nil?
      redirect_to admin_users_path
    end
  end

  private

  def get_role
    case user_group_params[:role]
    when "R" then @role = "référent"
    when "M" then @role = "membre"
    else
      @role = nil
    end
  end

  def users_filtered
    @users = policy_scope(User)
    @users = @users.search_by_first_last_name_and_email(params[:query]) if params[:query].present?
    @users = @users.includes(:user_groups).where(user_groups: { group_id: params[:groupe] }) if params[:groupe].present?
    @users = @users.includes(:user_groups).where(user_groups: { role: params[:role] }) if params[:role].present?
    @users = @users.order(:first_name).uniq
  end

  def create_user
    @user = User.new(user_params)
    @user.admin = false
    if @user.save
      create_user_group(@user)
      redirect_to admin_users_path
      SendFirstWelcomeMailJob.perform_later(@user, @group, @role)
    else
      users_filtered
      prepare_search_bar
      generate_pswd
      @chatrooms = Chatroom.includes(:chatroom_users).where(chatroom_users: { user: current_user })
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

  def prepare_search_bar
    @groups = Group.where(user: current_user).map do |group|
      [group.name, group.id]
    end
    @groups.insert(0, ['Groupe', ''])
    @roles = [["Role", ""], ["Membre", "M"], ["Référent", "R"]]
    @selected_group = params[:groupe].present? ? @groups.find { |g| g[1] == params[:groupe].to_i } : ['Groupe', '']
    @selected_role = params[:role].present? ? @roles.find { |r| r[1] == params[:role] } : ["Role", ""]
  end

  def generate_pswd
    alpha_num = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9]
    pwd = ''
    6.times do
      pwd += alpha_num.sample
    end
    @pwd = pwd
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
