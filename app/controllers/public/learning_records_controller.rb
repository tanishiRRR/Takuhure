class Public::LearningRecordsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @learning_records = current_end_user.learning_records.all

    if params[:month].present?
      @time = Time.local(params[:year],params[:month],1,00,00,00)
    else
      @time = Time.now
    end
  end

  def new
    @learning_record = LearningRecord.new
  end

  def create
    @learning_record = LearningRecord.new(learning_record_params)
    @learning_record.end_user_id = current_end_user.id
    @learning_record.start_time = Time.now
    @learning_record.date = Date.today
    if @learning_record.save
      redirect_to new_learning_record_path, success: '開始時刻を正常に打刻しました'
    else
      flash.now[:warning] = 'もう一度開始ボタンを押してください'
      render :new
    end
  end

  def end_count
    @learning_record = current_end_user.learning_records.find_by(is_record: 'true')
    @learning_record.end_time = Time.now
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
          i = Time.now.day - learning_record_over.start_time.day
          if i != 0
            learning_record_over.end_time = punctuation_time_end(learning_record_over.start_time.year, learning_record_over.start_time.month, learning_record_over.start_time.day)
          else
            learning_record_over.end_time = Time.now
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
    @learning_record = current_end_user.learning_records.where(date: params[:date]).order(start_time: :desc)
  end

  def edit
    @learning_record = LearningRecord.find(params[:id])
  end

  def update
    @learning_record = LearningRecord.find(params[:id])
    if @learning_record = LearningRecord.update(learning_record_params)
      @learning_record = current_end_user.learning_records.where(date: params[:date]).order(start_time: :desc)
      redirect_to learning_record_path, success: '学習時間を編集しました'
    else
      render :edit
    end
  end

  def destroy
  end

  private

    def learning_record_params
      params.require(:learning_record).permit(:end_user_id, :start_time, :end_time, :content_memo, :is_record)
    end

end
