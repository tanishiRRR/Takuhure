class Public::QuestionsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :end_user_scan, only: [:create, :destroy]

  def index
    @questions = current_end_user.questions.order(created_at: :asc)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.end_user_id = current_end_user.id
    @question.date = Date.current
    if @question.save
      redirect_to question_path(@question.id), success: '質問を投稿しました'
    else
      flash.now[:warning] = '全て入力してください'
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @supplemental_question = SupplementalQuestion.new
    @supplemental_questions = SupplementalQuestion.where(question_id: params[:id]).order(created_at: :asc)
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      redirect_to questions_path, danger: '質問を削除しました'
    end
  end

  private

    def question_params
      params.require(:question).permit(:end_user_id, :category_id, :title, :question, :is_answer, :date)
    end

    def end_user_scan
      unless current_end_user
        redirect_to end_users_my_page_path
      end
    end

end
