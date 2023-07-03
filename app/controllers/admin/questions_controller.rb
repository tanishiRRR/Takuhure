class Admin::QuestionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:end_user_id].present?
      @questions = Question.where(end_user_id: params[:end_user_id]).order(created_at: :desc).page(params[:page]).per(20)
    else
      @questions = Question.order(created_at: :desc).page(params[:page]).per(20)
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      redirect_to admin_questions_path(end_user_id: @question.end_user.id), danger: '質問を削除しました'
    end
  end
end
