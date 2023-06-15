class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  # 検索機能
  def search
    if params[:keyword].present?
      @keyword = params[:keyword]
      @questions = Question.search(@keyword)
    else
    end
  end
end
