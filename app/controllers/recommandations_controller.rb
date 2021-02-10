class RecommandationsController < ApplicationController
  def new
    @recommandation = Recommandation.new
    @axe = Axe.find(params[:axe_id])
    authorize @recommandation
  end
end
