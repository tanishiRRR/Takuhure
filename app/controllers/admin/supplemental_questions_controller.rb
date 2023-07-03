class Admin::SupplementalQuestionsController < ApplicationController
  def destroy
    supplemental_question = SupplementalQuestion.find(params[:id])
    # リダイレクト用に質問IDを定義する。
    question_id = supplemental_question.question_id
    if supplemental_question.destroy
      redirect_to admin_question_path(question_id), success: '補足を削除しました'
    end
  end
end
