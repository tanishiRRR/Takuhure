class SupplementalQuestion < ApplicationRecord

  # 質問
  belongs_to :question

  validates :question_id, presence: true
  # validates :supplemental_question, present: true

end
