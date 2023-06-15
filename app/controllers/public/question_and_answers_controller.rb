class Public::QuestionAndAnswersController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @questions = Question.all
  end

  def show
  end

end
