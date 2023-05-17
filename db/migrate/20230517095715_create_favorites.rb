class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      
      ##保存するカラム
      t.integer :end_user_id, null: false  # 会員ID
      t.integer :answer_id,   null: false  # 回答ID

      t.timestamps
    end
  end
end
