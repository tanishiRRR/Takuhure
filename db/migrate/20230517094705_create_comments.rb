class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      
      # 保存するカラム
      t.integer :end_user_id, null: false  # 会員ID
      t.integer :answer_id,   null: false  # 回答ID
      t.text :comment,        null: false  # コメント内容

      t.timestamps
    end
  end
end
