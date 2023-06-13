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
  # presence: trueで設定すると、booleanの値がfalseのときエラーが出る
  validates :is_answer, inclusion: {in: [true, false]}

  # 検索機能によ検索した場合
  def self.search(keyword)
    Question.where(['title like? OR question like?', '%'+keyword+'%', '%'+keyword+'%'])
  end

end
