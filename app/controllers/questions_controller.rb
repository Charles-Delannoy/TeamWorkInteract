class QuestionsController < ApplicationController
  before_action :set_question, only: [ :edit, :update, :destroy ]

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
  
  def update
    @survey = @question.survey
    @question.update(questions_params)
    if @question.save
      redirect_to survey_path(@survey, anchor: "question-#{@question.id}")
    else
      render :edit
    end
  end

  def destroy
    @survey = @question.survey
    @question.destroy
    redirect_to survey_path(@survey)
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
