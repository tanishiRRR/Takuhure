class Public::QuestionsController < ApplicationController

  def index

  end

  def top

  end

  def new
    @question = Question.new
  end

  def create

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
