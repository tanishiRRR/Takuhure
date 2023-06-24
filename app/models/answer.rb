class Answer < ApplicationRecord

  # 会員
  belongs_to :end_user

  # 質問
  belongs_to :question

  # コメント
  has_many :comments, dependent: :destroy

  # いいね
  has_many :favorites, dependent: :destroy
  # いいねの多い順に並べるためのアソシエーション
  has_many :favorited_users, through: :favorites, source: :end_user

  validates :end_user_id, presence: true
  validates :question_id, presence: true
  validates :answer, presence: true

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

end
