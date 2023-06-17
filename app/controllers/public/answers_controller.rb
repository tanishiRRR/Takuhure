class Public::AnswersController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @answers = current_end_user.answers.all.order(created_at: :asc)
  end

  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
    @comment = Comment.new
    if @question.end_user_id == current_end_user.id
      @answers = Answer.all.where(question_id: params[:question_id])
      @supplemental_questions = @question.supplemental_questions.all
      flash.now[:warning] = '自分の質問に回答をすることはできません'
      render 'public/question_and_answers/show'
    else @question.answers.pluck(:end_user_id).include?(current_end_user.id)
      @answers = Answer.all.where(question_id: params[:question_id])
      @supplemental_questions = @question.supplemental_questions.all
      flash.now[:warning] = 'すでに回答済みです'
      render 'public/question_and_answers/show'
    end
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.end_user_id = current_end_user.id
    @answer.question_id = params[:question_id]
    if @answer.save
      redirect_to answer_path(@answer.id), success: '回答を投稿しました'
    else
      @question = Question.find(params[:question_id])
      flash.now[:warning] = '回答を入力してください'
      render :new
    end
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      redirect_to answers_path, danger: '回答を削除しました'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:end_user_id, :question_id, :answer)
  end

end
