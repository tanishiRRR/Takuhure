class Public::QuestionsController < ApplicationController
  before_action :authenticate_end_user!
  # 他人には扱うことができないようにする設定
  before_action :end_user_scan, only: [:show, :destroy]

  def index
    @questions = current_end_user.questions.order(created_at: :desc).page(params[:page]).per(10)
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
      redirect_to new_question_path, warning: '全て入力してください'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    if question.update(question_params)
      redirect_to question_and_answer_path(question.id), success: '質問を編集しました'
    else
      redirect_to edit_question_path(question.id), warning: '質問を入力してください'
    end
  end

  def show
    @question = Question.find(params[:id])
    @supplemental_question = SupplementalQuestion.new
    @supplemental_questions = SupplementalQuestion.where(question_id: params[:id]).order(created_at: :asc)
  end

  def destroy
    question = Question.find(params[:id])
    if question.destroy
      redirect_to questions_path, success: '質問を削除しました'
    end
  end

  private

    def question_params
      params.require(:question).permit(:end_user_id, :category_id, :title, :question, :is_answer, :date)
    end

    def end_user_scan
      @question = Question.find(params[:id])
      unless @question.end_user.id == current_end_user.id
        redirect_to end_users_my_page_path
      end
    end

end
