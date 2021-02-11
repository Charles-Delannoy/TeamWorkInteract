class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  def index
    @surveys = policy_scope(Survey).order(created_at: :desc)
    authorize @surveys
  end

  def new
    @survey = Survey.new
    @questions = @survey.questions.build
    @propositions = @questions.propositions.build
    authorize @survey
  end

  def create
    @survey = Survey.new(surveys_params)
    @survey.user = current_user
    @question = @survey.questions.build(surveys_params[:question])
    raise
    authorize @survey
    if @survey.save
      redirect_to surveys_path
    else
      render :new
    end
  end

  def show
    @questions = @survey.questions
    @question = Question.new
  end

  def edit
  end

  def update
    @survey.update(surveys_params)
    if @survey.save
      redirect_to surveys_path
    else
      render :edit
    end
  end

  def destroy
    @survey.destroy
    redirect_to surveys_path
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
    authorize @survey
  end

  def surveys_params
    params.require(:survey).permit(:title, :description, :icon,
                                   questions_attributes: [:id, :title, :axe, :coef, :_destroy],
                                   propositions_attributes: [:id, :title, :value, :_destroy])
  end
end
