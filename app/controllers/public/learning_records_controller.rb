class Public::LearningRecordsController < ApplicationController
  before_action :authenticate_end_user!

  before_action :end_user_scan, only: [:edit, :update, :destroy]

  def index
    # 先月や来月等、今月以外のデータを見る場合の処理をifで分岐
    # 先月や来月等のデータを見る場合
    if params[:month].present?
      @time = Time.zone.local(params[:year],params[:month],1,00,00,00).to_time
    # 今月のデータを見る場合
    else
      @time = Time.current
    end
    @learning_records = current_end_user.learning_records
  end

  def new
    @learning_record = LearningRecord.new
  end

  def create
    @learning_record = LearningRecord.new(learning_record_params)
    @learning_record.end_user_id = current_end_user.id
    # 手動で学習記録を保存する場合の処理をifで分岐
    if params[:learning_record][:end_time_option].present?
      # 年月日指定を指定して、Time型を作成する
      @learning_record.start_time = Time.zone.local(params[:learning_record][:date].slice(0,4).to_i, params[:learning_record][:date].slice(5,2).to_i, params[:learning_record][:date].slice(8,2).to_i, params[:learning_record][:start_time_option].slice(0,2).to_i, params[:learning_record][:start_time_option].slice(3,2).to_i, 00).to_time
      @learning_record.end_time = Time.zone.local(params[:learning_record][:date].slice(0,4).to_i, params[:learning_record][:date].slice(5,2).to_i, params[:learning_record][:date].slice(8,2).to_i, params[:learning_record][:end_time_option].slice(0,2).to_i, params[:learning_record][:end_time_option].slice(3,2).to_i, 00).to_time
    end
    # 手動で学習記録を保存する場合の処理をifで分岐
    # 手動で学習記録を保存する場合
    if params[:learning_record][:end_time_option].present?
      if @learning_record.save
        redirect_to learning_record_path(params[:learning_record][:date]), success: '学習情報を保存しました'
      else
        # 「.join(' ')」をつけずに「~.errors.full_messages」のみの場合は、["エラー文"]の形で出力される。
        redirect_to learning_record_path(params[:learning_record][:date]), warning: @learning_record.errors.full_messages.join(' ')
      end
    else
    # 打刻機能で学習記録を保存する場合
      if @learning_record.save
        redirect_to new_learning_record_path, success: '開始時刻を正常に打刻しました'
      else
        flash.now[:warning] = '開始ボタンを押してください'
        render :new
      end
    end
  end

  # 打刻機能で終了を押したときの定義
  def end_count
    learning_record = current_end_user.learning_records.find_by(is_record: 'true')
    learning_record.end_time = Time.current.to_time
    # 0時を超えない場合
    if learning_record.end_time.day == learning_record.start_time.day
      if learning_record.update(learning_record_params)
        redirect_to new_learning_record_path, success: '終了時刻を正常に打刻しました'
      else
        flash.now[:warning] = 'もう一度終了ボタンを押してください'
        render :new
      end
    # 0時を超えた場合
    else
      # 日付をまたぐ場合、一回またぐ前の最終時間23時59分59秒で区切って保存する。
      # punctuation_time_endを作動させるには、コントローラー側から見てどのモデルかわかるように指定してあげる必要がある。
      learning_record.end_time = LearningRecord.punctuation_time_end(learning_record.start_time.year, learning_record.start_time.month, learning_record.start_time.day)
      if learning_record.update(learning_record_params)
        # 日付が一致するまでレコードを作成する。
        i = Time.current.day - learning_record.start_time.day
        k = 0
        while i != 0 do
          learning_record_over = LearningRecord.new(learning_record_params)
          learning_record_over.end_user_id = current_end_user.id
          # 学習開始日翌日以降の00時00分00秒を表すために区切り時間23時59分59秒にプラス1秒する。
          learning_record_over.start_time = learning_record.end_time + 24*60*60*k + 1
          learning_record_over.date = LearningRecord.punctuation_day(learning_record_over.start_time.year, learning_record_over.start_time.month, learning_record_over.start_time.day)
          i = Time.current.day - learning_record_over.start_time.day
          if i != 0
            learning_record_over.end_time = LearningRecord.punctuation_time_end(learning_record_over.start_time.year, learning_record_over.start_time.month, learning_record_over.start_time.day)
          else
            learning_record_over.end_time = Time.current.to_time
          end
          learning_record_over.save
          k += 1
        end
        redirect_to new_learning_record_path, success: '終了時刻を正常に打刻しました'
      else
        @learning_record = LearningRecord.new
        flash.now[:warning] = 'もう一度終了ボタンを押してください'
        render :new
      end
    end
  end

  def show
    @learning_record = LearningRecord.new
    # params[:id]には、"2023-06-13"のように年月日の順で"○○○○-○○-○○"が与えられる。
    # 1文字目(順番は0)から4文字が"年"、6文字目(順番は5)から2文字が"月"、9文字目(順番は8)から2文字が"日"を表す。
    @date = Date.new(params[:id].slice(0,4).to_i, params[:id].slice(5,2).to_i, params[:id].slice(8,2).to_i)
    @learning_records = current_end_user.learning_records
    # その日の学習記録一覧
    @learning_records_day = current_end_user.learning_records.where(date: params[:id]).order(start_time: :asc)
  end

  def edit
    @learning_record = LearningRecord.find(params[:id])
  end

  def update
    @learning_record = LearningRecord.find(params[:id])
    # 年月日指定を指定して、Time型を作成する
    @learning_record.start_time = Time.zone.local(@learning_record.date.year, @learning_record.date.month, @learning_record.date.day, params[:learning_record][:start_time_option].slice(0,2).to_i, params[:learning_record][:start_time_option].slice(3,2).to_i, 00).to_time
    @learning_record.end_time = Time.zone.local(@learning_record.date.year, @learning_record.date.month, @learning_record.date.day, params[:learning_record][:end_time_option].slice(0,2).to_i, params[:learning_record][:end_time_option].slice(3,2).to_i, 00).to_time
    if @learning_record.update(learning_record_params)
      redirect_to learning_record_path(@learning_record.date), success: '学習情報を編集しました'
    else
      flash.now[:warning] = '終了時間は開始時間より遅い時間を入力してください'
      render :edit
    end
  end

  def destroy
    learning_record = LearningRecord.find(params[:id])
    if learning_record.destroy
      redirect_to learning_record_path(learning_record.date), success: '学習情報を削除しました'
    end
  end

  private

    def learning_record_params
      params.require(:learning_record).permit(:end_user_id, :start_time, :end_time, :date, :content_memo, :is_record)
    end

    def end_user_scan
      @learning_record = LearningRecord.find(params[:id])
      unless @learning_record.end_user.id == current_end_user.id
        redirect_to end_users_my_page_path
      end
    end

end
