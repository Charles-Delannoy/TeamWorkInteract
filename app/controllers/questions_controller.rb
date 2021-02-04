class QuestionsController < ApplicationController

  def index
    @survey = Survey.find(params[:survey_id])
    @questions = Question.all
    authorize @questions
  end

  def new
    @survey = Survey.find(params[:survey_id])
    @question = Question.new
    authorize @question
  end

  def create
    @question = Question.new(questions_params)
    @survey = Survey.find(params[:survey_id])
    @question.survey = @survey
    authorize @question
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  private

  def questions_params
    params.require(:question).permit(:title, :coef, :axe_id)
  end
end
