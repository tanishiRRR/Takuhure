class Admin::AnswersController < ApplicationController

  before_action :authenticate_admin!

  def index
    if params[:end_user_id].present?
      @answers = Answer.where(end_user_id: params[:end_user_id]).order(created_at: :desc).page(params[:page]).per(20)
    else
      @answers = Answer.order(created_at: :desc).page(params[:page]).per(20)
    end
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def destroy
    answer = Answer.find(params[:id])
    if answer.destroy
      redirect_to admin_answers_path(end_user_id: answer.end_user.id), success: '回答を削除しました'
    end
  end
end
