class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  # 検索機能
  def search
    @categories = Category.all
    if params[:keyword].present?
      @keyword = params[:keyword]
      questions = Question.search(@keyword)
      @answered_questions = questions.where(is_answer: true).order(created_at: :asc)
      @looking_for_answers_questions = questions.where(is_answer: false).order(created_at: :asc)
    else
      redirect_to question_and_answers_path, danger: 'キーワードを入力してください'
    end
  end
end
