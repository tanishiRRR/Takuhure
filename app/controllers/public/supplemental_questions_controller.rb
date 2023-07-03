class Public::SupplementalQuestionsController < ApplicationController
  before_action :authenticate_end_user!
  # 他人には扱うことができないようにする設定
  before_action :end_user_scan, only: [:create, :destroy]

  def create
    supplemental_question = SupplementalQuestion.new(supplemental_question_params)
    supplemental_question.question_id = params[:question_id]
    if supplemental_question.save
      redirect_to question_path(params[:question_id]), success: '補足内容を追加しました'
    else
      redirect_to question_path(params[:question_id]), warning: '補足内容を入力してください'
    end
  end

  def destroy
    supplemental_question = SupplementalQuestion.find(params[:id])
    # リダイレクト用に質問IDを定義する。
    question_id = supplemental_question.question_id
    if supplemental_question.destroy
      redirect_to question_path(question_id), success: '補足を削除しました'
    end
  end

  private

    def supplemental_question_params
      params.require(:supplemental_question).permit(:question_id, :supplemental_question)
    end

    def end_user_scan
      unless current_end_user
        redirect_to end_users_my_page_path
      end
    end
end
