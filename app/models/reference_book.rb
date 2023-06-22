class ReferenceBook < ApplicationRecord
  # ReferenceBookテーブルのprimary_keyを「isbn」になるようコードを書く
  self.primary_key = 'isbn'

  # 会員
  belongs_to :end_user

  # 進捗度は0以上100以下
  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
