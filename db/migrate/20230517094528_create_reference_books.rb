class CreateReferenceBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :reference_books do |t|

      ##保存するカラム
      t.integer :end_user_id, null: false  # 会員ID

      t.timestamps
    end
  end
end
