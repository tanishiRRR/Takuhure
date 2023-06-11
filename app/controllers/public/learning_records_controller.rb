class Public::LearningRecordsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    if params[:month].present?
      @time = Time.zone.local(params[:year],params[:month],1,00,00,00).to_time
    else
      @time = Time.current
    end
    @learning_records = current_end_user.learning_records.all
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
      # byebug
    end
    # 手動で学習記録を保存する場合の処理をifで分岐
    if params[:learning_record][:end_time_option].present?
      if @learning_record.save
        redirect_to learning_record_path(params[:learning_record][:date]), success: '学習情報を保存しました'
      else
        @learning_records = current_end_user.learning_records.where(date: @learning_record.date).order(start_time: :asc)
        @date = @learning_record.date
        flash.now[:warning] = '終了時間は開始時間より遅い時間を入力してください'
        render :show
      end
    else
      if @learning_record.save
        redirect_to new_learning_record_path, success: '開始時刻を正常に打刻しました'
      else
        flash.now[:warning] = 'もう一度開始ボタンを押してください'
        render :new
      end
    end
  end

  def end_count
    @learning_record = current_end_user.learning_records.find_by(is_record: 'true')
    @learning_record.end_time = Time.current.to_time
    # 0時を超えない場合
    if @learning_record.end_time.day == @learning_record.start_time.day
      if @learning_record.update(learning_record_params)
        redirect_to new_learning_record_path, success: '終了時刻を正常に打刻しました'
      else
        flash.now[:warning] = 'もう一度終了ボタンを押してください'
        render :new
      end
    # 0時を超えた場合
    else
      @learning_record.end_time = punctuation_time_end(@learning_record.start_time.year, @learning_record.start_time.month, @learning_record.start_time.day)
      if @learning_record.update(learning_record_params)
        # 日付が一致するまでレコードを作成する。
        k = 0
        while i == 0 do
          learning_record_over = LearningRecord.new(learning_record_params)
          learning_record_over.end_user_id = current_end_user.id
          # 学習開始日翌日以降の00時00分00秒を表すために区切り時間23時59分59秒にプラス1秒する。
          learning_record_over.start_time = @learning_record.end_time + 24*60*60*k + 1
          learning_record_over.date = punctuation_day(learning_record_over.start_time.year, learning_record_over.start_time.month, learning_record_over.start_time.day)
          i = Time.current.day - learning_record_over.start_time.day
          if i != 0
            learning_record_over.end_time = punctuation_time_end(learning_record_over.start_time.year, learning_record_over.start_time.month, learning_record_over.start_time.day)
          else
            learning_record_over.end_time = Time.current.to_time
          end
          learning_record_over.save
          k += 1
        end
        redirect_to new_learning_record_path, success: '終了時刻を正常に打刻しました'
      else
        flash.now[:warning] = 'もう一度終了ボタンを押してください'
        render :new
      end
    end
  end

  def show
    @learning_record = LearningRecord.new
    @date = Date.new(params[:id].slice(0,4).to_i, params[:id].slice(5,2).to_i, params[:id].slice(8,2).to_i)
    @learning_records = current_end_user.learning_records.where(date: params[:id]).order(start_time: :asc)
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
    end
  end

  def destroy
    @learning_record = LearningRecord.find(params[:id])
    if @learning_record.destroy
      redirect_to learning_record_path(@learning_record.date), danger: '学習情報を削除しました'
    end
  end

  private

    def learning_record_params
      params.require(:learning_record).permit(:end_user_id, :start_time, :end_time, :date, :content_memo, :is_record)
    end

end
