class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      
      ##保存するカラム
      t.integer :end_user_id, null: false  # 会員ID
      t.integer :question_id, null: false  # 質問ID
      t.text :answer,         null: false  # 回答内容

      t.timestamps
    end
  end
end
