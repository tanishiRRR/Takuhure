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

  # 0時をまたぐ場合、日付を区切るための終了時間
  def self.punctuation_time_end(year, month, day)
    Time.zone.local(year, month, day, 23, 59, 59).to_time
  end

  # 日付をまたいだ場合の日付の処理
  def self.punctuation_day(year, month, day)
    Date.new(year, month, day)
  end

  def self.total_day_time(day)
    day_time = where(date: day)
    subtotal = 0
    day_time.each do |day_time|
      if day_time.end_time.present?
        subtotal += day_time.end_time - day_time.start_time
      else
        subtotal += 0
      end
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
      if month_time.end_time.present?
        subtotal += month_time.end_time - month_time.start_time
      else
        subtotal += 0
      end
    end
    subtotal/(60*60)
  end

end
