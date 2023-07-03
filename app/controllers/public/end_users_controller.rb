class Public::EndUsersController < ApplicationController

  # authenticate_user!は、deviseで使える。
  # 各アクションが動く前にログインしているかしていないかを判断し、
  # ログインしていなければアクションを動かすことなくログインページが表示されるようする
  before_action :authenticate_end_user!

  # ゲストログインユーザーはマイページの編集及び退会ができないようにする
  before_action :check_guest, only: [:edit, :update, :withdraw]

  def my_page
    @end_user = current_end_user
    @reference_books = ReferenceBook.where(end_user_id: current_end_user.id)
  end

  def index
    # EndUserから合格者一覧を取得する
    @end_users = EndUser.where(is_study: 1).page(params[:page]).per(15)
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
      flash.now[:warning] = '必須項目を入力してください'
      render :edit
    end
  end

  def unsubscribe
    @end_user = current_end_user
  end

  def withdraw
    @end_user = current_end_user
    # is_deleteのステータスをtrue(退会)にして保存
    @end_user.update(is_deleted: true)
    reset_session  #この記述で現在のログイン状況をリセットすることができる
    redirect_to root_path, success: '退会しました'
  end

  private

    def end_user_params
      params.require(:end_user).permit(:account_name, :email, :is_study, :exam_date, :is_deleted, :profile_image)
    end

    def check_guest
      @end_user = current_end_user
      if @end_user.email == 'guest@example.com'
        redirect_to end_users_my_page_path, danger: 'ゲストユーザーの会員情報編集・退会はできません'
      end
    end

end
