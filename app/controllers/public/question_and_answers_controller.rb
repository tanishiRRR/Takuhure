class Public::QuestionAndAnswersController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @supplemental_questions = @question.supplemental_questions.all
  end

end
