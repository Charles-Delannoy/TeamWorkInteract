class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  def index
    @surveys = policy_scope(Survey).order(created_at: :desc)
    authorize @surveys
  end

  def new
    @survey = Survey.new
    authorize @survey
  end

  def create
    @survey =Survey.new(surveys_params)
    @survey.user = current_user
    authorize @survey
    if @survey.save
      redirect_to survey_path(@survey)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @survey.update(surveys_params)
    if @survey.save
      redirect_to survey_path(@survey)
    else
      render :edit
    end
  end

  def destroy
    @survey.destroy
    redirect_to dashboard_path
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
    authorize @survey
  end

  def surveys_params
    params.require(:survey).permit(:title)
  end
end
