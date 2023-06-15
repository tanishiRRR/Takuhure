class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  # 検索機能
  def search
    if params[:keyword].present?
      @keyword = params[:keyword]
      @questions = Question.search(@keyword).order(created_at: :asc)
    else
      redirect_to questions_top_path, danger: 'キーワードを入力してください'
    end
  end
end
