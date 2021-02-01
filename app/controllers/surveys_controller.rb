class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :first_survey?, only: [:new, :create]

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

  private
  
  def first_survey?
    surveys = Survey.all
    if surveys
      surveys.each do |survey|
        if survey.user == current_user
          return false
        else
          return true
        end
      end
    else
      true
    end
  end

  def set_survey
    @survey = Survey.find(params[:id])
    authorize @survey
  end

  def surveys_params
    params.require(:survey).permit(:title, :start_date, :end_date)
  end
end
