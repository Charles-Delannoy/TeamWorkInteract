class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:edit, :update, :destroy]

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
      redirect_to campaigns_path(anchor: "campaign-#{@campaign.id}")
    else
      render :new
    end
  end

  def edit
  end

  def update
    @campaign.update(campaigns_params)
    if @campaign.save
      redirect_to campaigns_path(anchor: "campaign-#{@campaign.id}")
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
    authorize @campaign
  end

  def campaigns_params
    params.require(:campaign).permit(:start_date, :end_date, :survey_id, :title)
  end
end
