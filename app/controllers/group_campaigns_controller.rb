class GroupCampaignsController < ApplicationController

  def show
    @group_campaign = GroupCampaign.find(params[:id])
    @group = @group_campaign.group
    authorize @group_campaign
    @members = @group.users.includes(:user_groups).where(user_groups: {role: 'M'})
    @survey_completed = answered?
    @axes_labels = @group_campaign.score_calculation.keys.map(&:title)
    @scores = @group_campaign.score_calculation.values
  end

  def create
    @group_campaign = GroupCampaign.new(group_campaigns_params)
    authorize @group_campaign
    flash[:alert] = "Dates du groupe incompatible avec cette campagne" unless @group_campaign.save
    redirect_to campaign_path(group_campaigns_params[:campaign_id])
  end

  def destroy
    @group_campaign = GroupCampaign.find(params[:id])
    authorize @group_campaign
    begin
      @group_campaign.destroy
    rescue ActiveRecord::InvalidForeignKey
      flash[:alert] = "Opération impossible 👉 le groupe a commencé à répondre aux questions"
    end
    redirect_to campaign_path(@group_campaign.campaign)
  end

  private

  def answered?
    @members.each do |member|
      return false if member.completion_rate(@group_campaign) < 100
    end
    true
  end

  def group_campaigns_params
    params.require(:group_campaign).permit(:group_id, :campaign_id)
  end
end
