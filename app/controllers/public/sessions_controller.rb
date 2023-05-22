# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_deleted_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    end_users_my_page_path
  end

  # 退会しているかを判断するメソッド
  def reject_deleted_end_user
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return unless @end_user
    # 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @end_user.valid_password?(params[:end_user][:password]) && @end_user.is_deleted == true
      flash[:notice] = '退会済みの為、再登録が必要です。'
      redirect_to new_end_user_registration_path
    else
      flash[:notice] = '項目を入力してください'
    end
  end

end
