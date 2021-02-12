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

    # @campaign_groups.each do |campaign_group|
    #   GroupCampaign.create(group: campaign_group, campaign: @campaign)
    # end
    @group_campaign = GroupCampaign.new
  end

  def create_group_campaign
    @group_campaign = GroupCampaign.new(group_campaigns_params)
    @group_campaign.campaign = @campaign
    if @group_campaign.save
      redirect_to "show"
    else
      render :show
    end
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
