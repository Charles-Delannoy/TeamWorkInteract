class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    authorize @answer
  end

  def update
  end

  private

  def answer_params
    params.require(:answer).permit(:proposition_id)
  end
end
