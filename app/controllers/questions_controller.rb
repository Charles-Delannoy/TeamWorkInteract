class QuestionsController < ApplicationController

  def new
    @question = Question.new
    authorize @question
  end

  def create
    @question = Question.new(questions_params)
    @question.user = current_user
    authorize @question
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  private

  def questions_params
    params.require(:question).permit(:title, :coef)
  end
end
