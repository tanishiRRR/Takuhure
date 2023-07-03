class Question < ApplicationRecord

  # 会員
  belongs_to :end_user

  # カテゴリー
  belongs_to :category

  # 質問補足
  # dependent: :destroyによって、questionsテーブルにあるレコードを削除した時にsupplemental_questionsテーブルにあるレコードも一緒に削除してくれる
  has_many :supplemental_questions, dependent: :destroy

  # 回答
  # dependent: :destroyによって、questionsテーブルにあるレコードを削除した時にanswersテーブルにあるレコードも一緒に削除してくれる
  has_many :answers, dependent: :destroy

  validates :end_user_id, presence: true
  validates :category_id, presence: true
  validates :title, presence: true
  validates :question, presence: true
  # presence: trueで設定すると、booleanの値がfalseのときエラーが出る
  validates :is_answer, inclusion: {in: [true, false]}

  # 検索機能の定義
  def self.search(keyword)
    where(['title like? OR question like?', '%'+keyword+'%', '%'+keyword+'%'])
  end

end
