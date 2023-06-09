class Public::QuestionsController < ApplicationController
  before_action :authenticate_end_user!

  def index

  end

  def top

  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.end_user_id = current_end_user.id
    if @question.save
      redirect_to question_path(@question.id), success: '質問を投稿しました'
    else
      flash.now[:warning] = 'カテゴリーを選択してください'
      render :new
    end
  end

  def show

  end

  def destroy

  end

  private

    def question_params
      params.require(:question).permit(:end_user_id, :category_id, :title, :question, :is_answer)
    end

end
