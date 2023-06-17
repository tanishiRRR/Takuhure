class Answer < ApplicationRecord

  # 会員
  belongs_to :end_user

  # 質問
  belongs_to :question

  # コメント
  has_many :comments, dependent: :destroy

  # いいね
  has_many :favorites, dependent: :destroy

  validates :end_user_id, presence: true
  validates :question_id, presence: true
  validates :answer, presence: true
  validate :answer_yourself
  validate :duplicate_answer

  # 質問者は自分の質問に回答をすることができない。
  def answer_yourself
    if end_user_id == current_end_user.id
      errors.add('自分の質問に回答をすることはできません')
    end
  end

  # 回答済みの質問には回答をすることができない。
  def duplicate_answer
    if Answer.exists?(end_user_id: end_user_id.exsists) && Answer.exists?(question_id: question_id)
      errors.add('すでに回答済みです')
    end
  end

end
