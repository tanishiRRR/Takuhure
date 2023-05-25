# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_deleted_end_user, only: [:create]

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

  # ゲストログイン
  def guest_sign_in
    # find_or_create_by! => ゲストユーザーがあれば取り出す。なければ作成する
    # doの後は作成する場合に必要な情報を記入する
    end_user = EndUser.find_or_create_by!(email: 'guest@example.com') do |end_user|
      # ランダムパスワードを設定
      end_user.password = SecureRandom.urlsafe_base64
      # 入力必須にしているカラムを記述する
      end_user.account_name = 'ゲスト'
      # end_user.confirmed_at = Time.now  # Confirmableを使用している場合は必要
    end
    sign_in end_user
    redirect_to end_users_my_page_path, notice: 'ゲストユーザーとしてログインしました。'
  end

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
