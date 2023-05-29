class Favorite < ApplicationRecord

  # 会員
  belongs_to :end_user

  # 回答
  belongs_to :comment

end
