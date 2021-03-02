class RecommandationsController < ApplicationController
  before_action :set_reco, only: %i[edit update destroy]

  def new
    @recommandation = Recommandation.new
    @axe = Axe.find(params[:axe_id])
    authorize @recommandation
  end

  def create
    @recommandation = Recommandation.new(reco_params)
    @axe = Axe.find(params[:axe_id])
    @recommandation.axe = @axe
    authorize @recommandation
    if @recommandation.save
      redirect_to axe_path(@axe)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @recommandation.update(reco_params)
    if @recommandation.save
      redirect_to axe_path(@recommandation.axe)
    else
      render :edit
    end
  end

  def destroy
    @recommandation.destroy
  end

  private

  def set_reco
    @recommandation = Recommandation.find(params[:id])
    authorize @recommandation
  end

  def reco_params
    params.require(:recommandation).permit(:title, :description)
  end
end
