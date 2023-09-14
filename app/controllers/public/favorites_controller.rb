class Public::FavoritesController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @favorites = current_end_user.favorites.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    answer = Answer.find(params[:answer_id])
    favorite = Favorite.new
    favorite.end_user_id = current_end_user.id
    favorite.answer_id = params[:answer_id]
    favorite.save
    # redirect_to question_and_answer_path(answer.question.id)
  end

  def destroy
    answer = Answer.find(params[:answer_id])
    favorite = current_end_user.favorites.find_by(answer_id: answer.id)
    favorite.destroy
    # redirect_to question_and_answer_path(answer.question.id)
  end

end
