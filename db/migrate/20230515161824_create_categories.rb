class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|

      ##保存するカラム
      t.string :category_name, null: false  # カテゴリ名

      t.timestamps
    end
  end
end
