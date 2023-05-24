class Question < ApplicationRecord

  # 会員
  belongs_to :end_uer

  # カテゴリー
  belongs_to :category

  # 質問補足
  has_many :supplemental_questions, dependent: :destroy

  # 回答
  has_many :answers, dependent: :destroy

end
