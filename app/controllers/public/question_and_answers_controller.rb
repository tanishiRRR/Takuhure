class Public::QuestionAndAnswersController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @categories = Category.all
    # カテゴリー検索をしたときの場合分け
    if params[:category_id].present?
      questions = Question.where(category_id: params[:category_id])
      # 回答済みの質問
      @answered_questions = questions.where(is_answer: true).order(created_at: :desc)
      # 回答募集中の質問
      @looking_for_answers_questions = questions.where(is_answer: false).order(created_at: :desc)
    else
      @answered_questions = Question.where(is_answer: true).order(created_at: :desc)
      @looking_for_answers_questions = Question.where(is_answer: false).order(created_at: :desc)
    end
  end

  def show
    @question = Question.find(params[:id])
    # 回答をいいね順で並び替える
    @answers = @question.answers.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @supplemental_questions = @question.supplemental_questions
    @comment = Comment.new
  end

end
