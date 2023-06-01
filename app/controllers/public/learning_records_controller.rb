class Public::LearningRecordsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @learning_records = LearningRecord.all
  end

  def new
    @learning_record = LearningRecord.new
  end

  def create
    @learning_record = LearningRecord.new(learning_record_params)
    @learning_record.end_user_id = current_end_user.id
    @learning_record.start_time = Time.now
    if @learning_record.save!
      redirect_to new_learning_record_path, success: '開始時刻を正常に打刻しました'
    else
      flash.now[:warning] = 'もう一度開始ボタンを押してください'
      render :new
    end
  end

  def end_count
    @learning_record = LearningRecord.where(is_record: 'true')
    @learning_record.end_time = Time.now
    if @learning_record.update(learning_record_params)
      redirect_to new_learning_record_path, success: '終了時刻を正常に打刻しました'
    else
      flash.now[:warning] = 'もう一度終了ボタンを押してください'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def learning_record_params
      params.require(:learning_record).permit(:end_user_id, :start_time, :end_time, :content_memo, :is_record)
    end

end
