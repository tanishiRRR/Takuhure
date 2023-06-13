class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  # 検索機能
  def search
    @keyword = params[:keyword]
    @questions = Question.search(@keyword)
  end
end
