class Public::SupplementalQuestionsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @supplemental_question = SupplementalQuestion.new(supplemental_question_params)
    @supplemental_question.question_id = params[:question_id]
    if @supplemental_question.save
      redirect_to question_path(params[:question_id]), success: '補足内容を追加しました'
    else
      @end_user = current_end_user
      @question = current_end_user.questions.find(params[:question_id])
      flash.now[:warning] = '補足内容を入力してください'
      render :new
    end
  end

  def destroy
  end

  private

    def supplemental_question_params
      params.require(:supplemental_question).permit(:question_id, :supplemental_question)
    end
end
