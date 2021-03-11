class AnswersController < ApplicationController
  before_action :set_answer, only: [:update]

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
    answer_params[:proposition_id] = answer_params[:proposition_id].to_i
    @answer.update(answer_params)
    @answer.save
    redirect_to survey_path(@current_campaign.survey)
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
    puts @answer
    authorize @answer
  end

  def answer_params
    params.require(:answer).permit(:proposition_id)
  end
end
