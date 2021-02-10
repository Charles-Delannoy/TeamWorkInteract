class RecommandationsController < ApplicationController
  def new
    @recommandation = Recommandation.new
    @axe = Axe.find(params[:axe_id])
    authorize @recommandation
  end

  def create
    @recommandation = Recommandation.new(reco_params)
    @axe = Axe.find(params[:axe_id])
  end

  private

  def reco_params
  end
end
