class Category < ApplicationRecord

  # 質問
  has_many :questions

  validates :category_name, presence: true, uniqueness: true  # uniqueness:trueでテーブル全体での重複を防ぐ(一つの名前のラベル名しか保存できないようにする)

end
