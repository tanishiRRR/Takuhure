class Admin::AnswersController < ApplicationController

  def index
    if params[:end_user_id].present?
      @answers = Answer.where(end_user_id: params[:category_id]).order(created_at: :asc)
    else
      @answers = Answer.all.order(created_at: :asc)
    end
  end

  def show
  end

  def destroy
  end
end
