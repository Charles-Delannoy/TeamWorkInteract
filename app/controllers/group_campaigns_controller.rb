class GroupCampaignsController < ApplicationController

  def create
    @group_campaign = GroupCampaign.new(group_campaigns_params)
    # @group_campaign.campaign = @campaign
    authorize @group_campaign
    if @group_campaign.save
      redirect_to campaign_path(group_campaigns_params[:campaign_id])
    else
      render "pages/dashboard"
    end
  end

  def destroy
    @group_campaign = GroupCampaign.find(params[:id])
    authorize @group_campaign
    @group_campaign.destroy
    redirect_to campaign_path(@group_campaign.campaign)
  end

  private

  def group_campaigns_params
    params.require(:group_campaign).permit(:group_id, :campaign_id)
  end
end
