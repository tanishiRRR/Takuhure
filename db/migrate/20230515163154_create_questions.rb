class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|

      ##保存するカラム
      t.integer :end_user_id, null: false                  # 会員ID
      t.integer :category_id, null: false                  # カテゴリID
      t.string :title,        null: false                  # タイトル
      t.text :question,       null: false                  # 質問内容
      t.boolean :is_ansewer,  null: false, default: false  # 回答フラグ

      t.timestamps
    end
  end
end
