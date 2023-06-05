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
end
