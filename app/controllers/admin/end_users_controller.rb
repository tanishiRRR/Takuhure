class Admin::EndUsersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to admin_end_user_path(@end_user), success: '会員情報を編集しました'
    else
      if @end_user.account_name.empty?
        flash.now[:warning] = 'アカウント名を入力してください'
      elsif @end_user.email.empty?
        flash.now[:warning] = 'メールアドレスを入力してください'
      else
        flash.now[:warning] = '既に登録済みのメールアドレスは入力できません'
      end
      render :edit
    end
  end

  private

    def end_user_params
      params.require(:end_user).permit(:account_name, :email, :is_study, :exam_date, :is_deleted)
    end

end
