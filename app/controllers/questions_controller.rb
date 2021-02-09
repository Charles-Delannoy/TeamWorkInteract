class QuestionsController < ApplicationController
  before_action :set_question, only: [ :show, :edit, :update, :destroy ]

  def show
    @propositions = @question.propositions
    @proposition = Proposition.new
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
      redirect_to survey_path(@survey, anchor: "question-#{@question.id}")
    else
      @questions = @survey.questions
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
    @question.destroy
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
