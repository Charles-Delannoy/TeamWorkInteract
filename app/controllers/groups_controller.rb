class GroupsController < ApplicationController
  before_action :catch_and_authorize_group, only: %i[edit update destroy]

  def index
    @groups = policy_scope(Group).where(user: current_user)
    # @current_groups = @groups.where()
    new
  end

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    authorize @group
    @group.user = current_user
    if @group.save
      redirect_to groups_path(anchor: "group-#{@group.id}")
    else
      render :new
    end
  end

  def edit
  end

  def update
    @group.update(group_params)
    @group.save ? (redirect_to groups_path) : (render :new)
  end

  def destroy
    @group.destroy
  end

  private

  def catch_and_authorize_group
    @group = Group.find(params[:id])
    authorize @group
  end

  def group_params
    params.require(:group).permit(:name, :start_date, :end_date, :description, :id)
  end

end
