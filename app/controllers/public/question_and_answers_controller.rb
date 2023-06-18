class Public::QuestionAndAnswersController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @categories = Category.all
    if params[:category_id].present?
      @questions = Question.where(category_id: params[:category_id]).order(created_at: :asc)
    else
      @questions = Question.all.order(created_at: :asc)
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @supplemental_questions = @question.supplemental_questions.all
    @comment = Comment.new
  end

end
