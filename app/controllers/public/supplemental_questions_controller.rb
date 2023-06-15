class Public::SupplementalQuestionsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @supplemental_question = SupplementalQuestion.new(supplemental_question_params)
    @supplemental_question.question_id = params[:question_id]
    if @supplemental_question.save
      redirect_to question_path(params[:question_id]), success: '補足内容を追加しました'
    else
      @end_user = current_end_user
      @question = Question.find(params[:question_id])
      @supplemental_questions = SupplementalQuestion.where(question_id: params[:question_id]).order(created_at: :asc)
      flash.now[:warning] = '補足内容を入力してください'
      render 'public/questions/show'
    end
  end

  def destroy
    @supplemental_question = SupplementalQuestion.find(params[:id])
    # リダイレクト用に質問IDを定義する。
    @question_id = @supplemental_question.question_id
    if @supplemental_question.destroy
      redirect_to question_path(@question_id), danger: '補足を削除しました'
    end
  end

  private

    def supplemental_question_params
      params.require(:supplemental_question).permit(:question_id, :supplemental_question)
    end
end
