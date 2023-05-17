class CreateLearningRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_records do |t|
      
      ##保存するカラム
      t.integer :end_user_id, null: false  # 会員ID
      t.time :start_time,     null: false  # 開始時刻
      t.time :end_time,       null: false  # 終了時刻
      t.text :content_memo,   null: false  # 内容メモ
      t.date :date,           null: false  # 日付

      t.timestamps
    end
  end
end
