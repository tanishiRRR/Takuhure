class Public::GuestSessionsController < Devise::SessionsController
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
end