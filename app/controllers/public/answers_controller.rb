class Public::AnswersController < ApplicationController
  before_action :authenticate_end_user!

  before_action :end_user_scan, only: [:destroy]

  def index
    @answers = current_end_user.answers.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
    if @question.end_user_id == current_end_user.id
      @answers = Answer.where(question_id: params[:question_id])
      redirect_to question_and_answer_path(params[:question_id]), warning: '自分の質問に回答をすることはできません'
    elsif @question.answers.exists?(end_user_id: current_end_user.id)
      # elseにすると上記条件式がfalseでもquestion_and_answerのページに留まってしまい、answerのページに遷移できない
      @answers = Answer.where(question_id: params[:question_id])
      redirect_to question_and_answer_path(params[:question_id]), warning: 'すでに回答済みです'
    end
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.end_user_id = current_end_user.id
    @answer.question_id = params[:question_id]
    question = Question.find(params[:question_id])
    if @answer.save
      # 回答待ちの質問を回答済みにする
      if question.is_answer == false
        question.update(is_answer: true)
      end
      redirect_to question_and_answer_path(params[:question_id]), success: '回答を投稿しました'
    else
      @question = Question.find(params[:question_id])
      redirect_to new_answer_path(question_id: params[:question_id]), warning: '回答を入力してください'
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:id])
  end

  def update
    answer = Answer.find(params[:id])
    if answer.update(answer_params)
      redirect_to question_and_answer_path(answer.question.id), success: '回答を編集しました'
    end
  end

  def destroy
    answer = Answer.find(params[:id])
    # 回答していた質問が、回答を一つも持たなくなった場合、回答待ちへ変更する
    answer.destroy
    unless answer.question.answers.any?
      answer.question.update(is_answer: false)
    end
    redirect_to answers_path, success: '回答を削除しました'
  end

  private

    def answer_params
      params.require(:answer).permit(:end_user_id, :question_id, :answer)
    end

    def end_user_scan
      unless current_end_user
        redirect_to end_users_my_page_path
      end
    end

end
