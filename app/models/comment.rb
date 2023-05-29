class Comment < ApplicationRecord

  # 会員
  belongs_to :end_uer

  # 回答
  belongs_to :answer

end
