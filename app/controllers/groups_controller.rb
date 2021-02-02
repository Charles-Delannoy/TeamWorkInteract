class GroupsController < ApplicationController

  def index
    @groups = policy_scope(Group).where(user: current_user)
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
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    catch_and_authorize_group
  end

  def update
    catch_and_authorize_group
    @group.update(group_params)
    @group.save ? (redirect_to groups_path) : (render :new)
  end

  def destroy
    catch_and_authorize_group
    @group.destroy
    redirect_to groups_path
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
