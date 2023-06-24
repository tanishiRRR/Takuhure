class Public::QuestionAndAnswersController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @categories = Category.all
    if params[:category_id].present?
      questions = Question.where(category_id: params[:category_id])
      @answered_questions = questions.where(is_answer: true).order(created_at: :asc)
      @looking_for_answers_questions = question.where(is_answer: false).order(created_at: :asc)
    else
      @answered_questions = Question.where(is_answer: true).order(created_at: :asc)
      @looking_for_answers_questions = Question.where(is_answer: false).order(created_at: :asc)
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @supplemental_questions = @question.supplemental_questions.all
    @comment = Comment.new
  end

end
