class Public::EndUsersController < ApplicationController

  # authenticate_user!は、deviseで使える。
  # 各アクションが動く前にログインしているかしていないかを判断し、
  # ログインしていなければアクションを動かすことなくログインページが表示されるようする
  before_action :authenticate_end_user!

  # 他人には扱うことができないようにする設定
  before_action :end_user_scan, only: [:show, :edit, :update, :unsubscribe, :withdraw]

  # ゲストログインユーザーはマイページの編集及び退会ができないようにする
  before_action :check_guest, only: [:update, :withdraw]

  def my_page
    @end_user = current_end_user
    @reference_books = ReferenceBook.where(end_user_id: current_end_user.id)
  end

  def index
    # EndUserから合格者一覧を取得する
    @end_users = EndUser.where(is_study: 1)
  end

  def show
    @end_user = EndUser.find(params[:id])
    @reference_books = ReferenceBook.where(end_user_id: @end_user.id)
  end

  def edit
    @end_user = current_end_user
  end

  def update
    @end_user = current_end_user
    if @end_user.update(end_user_params)
      redirect_to end_users_my_page_path, success: '登録情報を編集しました'
    else
      render :edit
    end
  end

  def unsubscribe
    @end_user = current_end_user
  end

  def withdraw
    @end_user = current_end_user
    @end_user.update(is_deleted: true)
    reset_session  #この記述で現在のログイン状況をリセットすることができる
    redirect_to root_path, success: '退会しました'
  end

  private

    def end_user_params
      params.require(:end_user).permit(:account_name, :email, :is_study, :exam_date, :is_deleted, :profile_image)
    end

    def end_user_scan
      unless current_end_user
        redirect_to end_users_my_page_path
      end
    end

    def check_guest
      @end_user = current_end_user
      if @end_user.email == 'guest@example.com'
        redirect_to end_users_my_page_path, danger: 'ゲストユーザーの編集・退会はできません'
      end
    end

end
