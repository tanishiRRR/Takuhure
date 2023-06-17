class LearningRecord < ApplicationRecord

  # 会員
  belongs_to :end_user

  validates :end_user_id, presence: true
  validates :start_time, presence: true
  validates :date, presence: true
  validates :is_record, inclusion: {in: [true, false]}
  validate :do_not_registration_time

  def do_not_registration_time
    if end_time.present?
      errors.add('終了時間は、開始時間より遅い時間を入力してください') unless start_time < end_time
    end
  end

  # 0時を超えた場合の開始時間
  def punctuation_time_start(year, month, day)
    Time.zone.local(year, month, day, 00, 00 ,00).to_time
  end

  # 0時を超えた処理後、さらに0時をまたぐときの終了時間
  def punctuation_time_end(year, month, day)
    Time.zone.local(year, month, day, 23, 59, 59).to_time
  end

  # 日付を超えた場合の日付の処理
  def punctuation_day(year, month, day)
    Date.new(year, month, day)
  end

  def self.total_day_time(day)
    day_time = where(date: day)
    subtotal = 0
    day_time.each do |day_time|
      subtotal += day_time.end_time - day_time.start_time
    end
    subtotal/(60*60)
  end

  def self.total_month_time(year, month)
    if month < 10
      month_time = where("date LIKE ?", "#{year}-0#{month}%")
    else
      month_time = where("date LIKE ?", "#{year}-#{month}%")
    end
    subtotal = 0
    month_time.each do |month_time|
      subtotal += month_time.end_time - month_time.start_time
    end
    subtotal/(60*60)
  end

end
