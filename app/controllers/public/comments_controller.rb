class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  before_action :end_user_scan, only: [:destroy]

  def index
    @comments = current_end_user.comments.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    comment = Comment.new(comment_params)
    comment.end_user_id = current_end_user.id
    comment.answer_id = params[:answer_id]
    if comment.save
      redirect_to question_and_answer_path(comment.answer.question.id)
    else
      answer = Answer.find(params[:answer_id])
      redirect_to question_and_answer_path(answer.question.id), warning: '空のコメントは投稿できません'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to comments_path, danger: '質問を削除しました'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:comment)
      # createのコントローラー内で
      # comment.end_user_id = current_user.idとcomment.answer_id = answer.idを記載しているため、ストロングパラメーターに書かなくてもOk。
      # ストロングパラメータに書かないといけないのはフォームから飛んできたデータ。
      # end_user_idとanswer_idはフォームから飛んでこないので書かなくてもOK。
      # (書いても作動はする)
    end

    def end_user_scan
      unless current_end_user
        redirect_to end_users_my_page_path
      end
    end
end
