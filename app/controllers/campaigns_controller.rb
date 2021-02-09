class CampaignsController < ApplicationController

  def index
    @campaigns = policy_scope(Campaign).order(end_date: :asc)
    authorize @campaigns
    new
  end

  def new
    @campaign = Campaign.new
    authorize @campaign
  end

  def create
    @campaign = Campaign.new(campaigns_params)
    authorize @campaign
    if @campaign.save
      redirect_to campaigns_path
    else
      render :new
    end
  end

  private

  def campaigns_params
    params.require(:campaign).permit(:start_date, :end_date, :survey_id, :title)
  end
end
