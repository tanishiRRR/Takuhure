class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @comments = current_end_user.comments.all.order(created_at: :asc)
  end

  def new
  end

  def create
    answer = Answer.find(params[:answer_id])
    comment = Comment.new(comment_params)
    comment.end_user_id = current_end_user.id
    comment.answer_id = answer.id
    comment.save
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
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
end
