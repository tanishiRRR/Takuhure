class Answer < ApplicationRecord

  # 会員
  belongs_to :end_user

  # 質問
  belongs_to :question

  # コメント
  has_many :comments, dependent: :destroy

  # いいね
  has_many :favorites, dependent: :destroy

end
