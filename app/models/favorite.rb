class Favorite < ApplicationRecord

  # 会員
  belongs_to :end_user

  # 回答
  belongs_to :answer

  validates :end_user_id, presence: true
  validates :answer_id,   presence: true

end
