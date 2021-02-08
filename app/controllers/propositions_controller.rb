class PropositionsController < ApplicationController

  def create
    @proposition = Proposition.new(propositions_params)
    @question = Question.find(params[:question_id])
    @proposition.question = @question
    authorize @proposition
    if @proposition.save
      redirect_to question_path(@question)
    else
      render "questions#show"
    end
  end

  private

  def propositions_params
    params.require(:proposition).permit(:title, :value)
  end
end
