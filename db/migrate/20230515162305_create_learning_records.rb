class CreateLearningRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_records do |t|

      ##保存するカラム
      t.integer :end_user_id, null: false  # 会員ID
      t.datetime :start_time, null: false  # 開始時刻
      t.datetime :end_time                 # 終了時刻
      t.date :date,           null: false  # 日付
      t.text :content_memo                 # 内容メモ
      t.boolean :is_record,   null: false  # 打刻ステータス

      t.timestamps
    end
  end
end
