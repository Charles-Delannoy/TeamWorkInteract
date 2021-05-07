class AnswersController < ApplicationController
  before_action :set_answer, only: [:update]

  def create
    answer_params[:proposition_id] = answer_params[:proposition_id].to_i
    @answer = Answer.new(answer_params)
    @group_campaign = GroupCampaign.where(campaign: @current_campaign, group: @current_group).first
    @answer.user = current_user
    @answer.group_campaign = @group_campaign
    authorize @answer
    save_answer
  end

  def update
    answer_params[:proposition_id] = answer_params[:proposition_id].to_i
    @answer.update(answer_params)
    save_answer
  end

  private

  def save_answer
    questions = @answer.group_campaign.survey.questions
    if @answer.save
      next_question = questions[questions.index(@answer.question) + 1]
    else
      last_answer = Answer.where(user: current_user).last
      survey_started = current_user.completion_rate(@group_campaign) > 0
      last_question = Answer.where(user: current_user).last.question if survey_started
      next_question = survey_started ? questions[questions.index(last_question) + 1] : nil
      flash[:alert] = 'Vous devez selectionner une réponse'
    end
    redirect_to survey_path(@current_campaign.survey, next_question: next_question)
  end

  def set_answer
    @answer = Answer.find(params[:id])
    authorize @answer
  end

  def answer_params
    params.require(:answer).permit(:proposition_id)
  end
end
