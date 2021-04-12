class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  def index
    @campaigns = policy_scope(Campaign).order(end_date: :asc)
    authorize @campaigns
    new
  end

  def show
    groups = Group.where(user: current_user)
    @campaign_groups = @campaign.groups
    @groups = groups.select do |group|
      group.campaigns.include?(@campaign) == false
    end
    @group_campaign = GroupCampaign.new
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
      @campaigns = policy_scope(Campaign).order(end_date: :asc)
      render :index
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
    begin
      @campaign.destroy
    rescue ActiveRecord::InvalidForeignKey
      flash[:alert] = "Opération impossible 👉 des groupes ont commencés à répondre aux questionnaire de la campagne"
      @campaigns = policy_scope(Campaign).order(end_date: :asc)
      render :index
    end
  end

  private

  def group_campaigns_params
    params.require(:campaign).permit(:group_id)
  end

  def set_campaign
    @campaign = Campaign.find(params[:id])
    authorize @campaign
  end

  def campaigns_params
    params.require(:campaign).permit(:start_date, :end_date, :survey_id, :title)
  end
end
