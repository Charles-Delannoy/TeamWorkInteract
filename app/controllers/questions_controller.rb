class QuestionsController < ApplicationController

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
      redirect_to survey_path(@survey, anchor: "question-#{@question.id}")
    else
      render "surveys/show"
    end
  end

  def edit
    
  end

  private

  def set_question
    @question = Question.find(params[:id])
    authorize @question
  end

  def questions_params
    params.require(:question).permit(:title, :coef, :axe_id)
  end
end
