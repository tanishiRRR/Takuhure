class LearningRecord < ApplicationRecord

  # 会員
  belongs_to :end_user

  def punctuation_time_start(year, month, day)
    Time.local(year, month, day, 00, 00 ,00)
  end

  def punctuation_time_end(year, month, day)
    Time.local(year, month, day, 23, 59, 59)
  end

  def punctuation_day(year, month, day)
    Date.new(year, month, day)
  end

  def self.total_time(day)
    @day_time = where(date: day)
    subtotal = 0
    @day_time.each do |day_time|
      subtotal += day_time.end_time - day_time.start_time
    end
    subtotal/(60*60*60)
  end

end
