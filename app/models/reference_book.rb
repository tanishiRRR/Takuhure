class ReferenceBook < ApplicationRecord
  # ReferenceBookテーブルのprimary_keyを「isbn」になるようコードを書く
  self.primary_key = 'isbn'

  # 会員
  belongs_to :end_user

end
