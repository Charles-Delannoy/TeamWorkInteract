class AnswersController < ApplicationController
  def create
    answer_params[:proposition_id] = answer_params[:proposition_id].to_i
    @answer = Answer.new(answer_params)
    @group_campaign = GroupCampaign.where(campaign: @current_campaign, group: @current_group).first
    @answer.user = current_user
    @answer.group_campaign = @group_campaign
    authorize @answer
    @answer.save
    redirect_to survey_path(@current_campaign.survey)
  end

  def update

  end

  private

  def answer_params
    params.require(:answer).permit(:proposition_id)
  end
end
