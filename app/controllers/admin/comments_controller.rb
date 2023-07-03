class Admin::CommentsController < ApplicationController

  before_action :authenticate_admin!

  def index
    if params[:end_user_id].present?
      @comments = Comment.where(end_user_id: params[:end_user_id]).order(created_at: :desc).page(params[:page]).per(20)
    else
      @comments = Comment.order(created_at: :desc).page(params[:page]).per(20)
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @comments = Comment.where(answer_id: params[:id]).order(created_at: :asc)
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to admin_comments_path(end_user_id: comment.end_user.id), success: 'コメントを削除しました'
    end
  end

end
