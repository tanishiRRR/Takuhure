class Question < ApplicationRecord

  # 会員
  belongs_to :end_user

  # カテゴリー
  belongs_to :category

  # 質問補足
  has_many :supplemental_questions, dependent: :destroy

  # 回答
  has_many :answers, dependent: :destroy

  validates :end_user_id, presence: true
  validates :category_id, presence: true
  validates :title, presence: true
  validates :question, presence: true

end
