class PropositionsController < ApplicationController
  before_action :set_proposition, only: [ :edit, :update, :destroy ]

  def create
    @proposition = Proposition.new(propositions_params)
    @question = Question.find(params[:question_id])
    @proposition.question = @question
    authorize @proposition
    if @proposition.save
      redirect_to question_path(@question, anchor: "proposition-#{@proposition.id}")
    else
      @propositions = @question.propositions
      render "questions#show"
    end
  end

  def edit
  end
  
  def update
    @question = @proposition.question
    @proposition.update(propositions_params)
    if @proposition.save
      redirect_to question_path(@question, anchor: "proposition-#{@proposition.id}")
    else
      render :edit
    end
  end

  def destroy
    @proposition.destroy
  end

  private

  def set_proposition
    @proposition = Proposition.find(params[:id])
    authorize @proposition
  end

  def propositions_params
    params.require(:proposition).permit(:title, :value)
  end
end
