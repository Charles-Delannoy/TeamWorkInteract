class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  def index
    @surveys = policy_scope(Survey).order(created_at: :desc)
    authorize @surveys
  end

  def new
    @survey = Survey.new
    @question = @survey.questions.build
    @proposition = @question.propositions.build
    authorize @survey
  end

  def create
    if params[:survey_id]
      duplicate
    else
      @survey = Survey.new(surveys_params)
      @survey.user = current_user
      authorize @survey
      @survey.save ? (redirect_to surveys_path) : (render :new)
    end
  end

  def show
    @questions = @survey.questions
    @question = Question.new
    @group_campaign = GroupCampaign.where(campaign: @current_campaign, group: @current_group).first
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

  def duplicate
    survey = Survey.find(params[:survey_id])
    authorize survey
    title = get_next_free_title(survey)
    dup_survey = Survey.new(title: title, description: survey.description, user: current_user)
    dup_survey.save
    survey.questions.each { |question| duplicate_question(question, dup_survey) }
    redirect_to surveys_path
  end

  def get_next_free_title(survey)
    i = 1
    until title_free?("#{survey.title} (copie #{i})")
      i += 1
    end
    "#{survey.title} (copie #{i})"
  end

  def title_free?(title)
    Survey.where(title: title).empty?
  end

  def set_survey
    @survey = Survey.find(params[:id])
    authorize @survey
  end

  def surveys_params
    params.require(:survey).permit(:title, :description,
                                   questions_attributes: [:id, :title, :axe_id, :coef, :_destroy,
                                                          propositions_attributes: [:id, :title, :value, :_destroy]])
  end

  def duplicate_question(question, new_survey)
    dup_question = Question.new(title: question.title, coef: question.coef, axe: question.axe, survey: new_survey)
    dup_question.save
    question.propositions.each { |proposition| duplicate_proposition(proposition, dup_question) }
  end

  def duplicate_proposition(proposition, new_question)
    dup_proposition = Proposition.new(title: proposition.title, value: proposition.value, question: new_question)
    dup_proposition.save
  end
end
