# frozen_string_literal: true

class Public::PasswordsController < Devise::PasswordsController
  before_action :check_guest, only: [:create]
  before_action :reject_deleted_end_user, only: [:create]

  def check_guest
    # downcaseで大文字小文字を無視
    if params[:end_user][:email].downcase == 'guest@example.com'
      redirect_to root_path, danger: 'ゲストユーザーのパスワード再設定はできません'
    end
  end

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  protected

   # 退会しているかを判断するメソッド
  def reject_deleted_end_user
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return unless @end_user
    # 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @end_user.is_deleted == true
      redirect_to new_end_user_registration_path, warning: '退会済みの為、再登録が必要です。'
    end
  end
end
