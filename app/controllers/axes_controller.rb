class AxesController < ApplicationController
  before_action :set_axe, only: [:show, :edit, :update, :destroy]

  def index
    @axes = policy_scope(Axe).order(created_at: :desc)
    authorize @axes
    new
  end

  def new
    @axe = Axe.new
    authorize @axe
  end

  def create
    @axe = Axe.new(axes_params)
    @axe.user = current_user
    authorize @axe
    if @axe.save
      redirect_to axes_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @axe.update(axes_params)
    if @axe.save
      redirect_to axes_path
    else
      render :edit
    end
  end

  def destroy
    @axe.destroy
    redirect_to axes_path
  end

  private

  def set_axe
    @axe = Axe.find(params[:id])
    authorize @axe
  end

  def axes_params
    params.require(:axe).permit(:title, :description, :icon)
  end
end
