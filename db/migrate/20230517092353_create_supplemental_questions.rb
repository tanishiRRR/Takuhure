class CreateSupplementalQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :supplemental_questions do |t|

      ##保存するカラム
      t.integer :question_id,        null: false  # 質問ID
      t.text :supplemental_question, null: false  # 質問補足内容

      t.timestamps
    end
  end
end
