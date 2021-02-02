class AxesController < ApplicationController
  before_action :set_axe, only: [:show, :edit, :update, :destroy]

  def index
    @axes = policy_scope(Axe).order(created_at: :desc)
    authorize @axes
  end

  private

  def set_axe
    @axe = Axe.find(params[:id])
    authorize @axe
  end

  def axes_params
    params.require(:axe).permit(:title)
  end
end
