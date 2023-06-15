class Public::QuestionAndAnswersController < ApplicationController
  before_action :authenticate_end_user!

  def index
    if params[:category_id].present?
      @questions = Question.where(category_id: params[:category_id])
    else
      @questions = Question.all
    end
  end

  def show
    @question = Question.find(params[:id])
    @supplemental_questions = @question.supplemental_questions.all
  end

end
