class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  before_action :end_user_scan, only: [:destroy]

  def index
    @comments = current_end_user.comments.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    answer = Answer.find(params[:answer_id])
    comment = current_end_user.comments.new(comment_params)
    comment.answer_id = answer.id
    # comment.end_user_id = current_end_user.id
    # comment.answer_id = params[:answer_id]
    if comment.save
      @answer = Answer.find(params[:answer_id])
      @comment = Comment.new
      flash.now[:success] = "コメントを投稿しました"
      # redirect_to question_and_answer_path(comment.answer.question.id), success:'コメントを投稿しました'
    else
      flash.now[:warning] = "空のコメントは投稿できません"
      # answer = Answer.find(params[:answer_id])
      # redirect_to question_and_answer_path(answer.question.id), warning: '空のコメントは投稿できません'
    end
  end

  # def edit
  #   @comment = Comment.find(params[:id])
  # end

  # def update
  #   comment = Comment.find(params[:id])
  #   if comment.update(comment_params)

  #   else

  #   end
  # end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to comments_path, success: 'コメントを削除しました'
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
