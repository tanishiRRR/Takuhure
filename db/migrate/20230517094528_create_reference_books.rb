class CreateReferenceBooks < ActiveRecord::Migration[6.1]
  def change
    # ReferenceBookテーブルのprimary_keyは「id」ではなく、商品の固有の番号である「isbn」を使う
    create_table :reference_books, id: false do |t|

      # 保存するカラム
      t.integer :end_user_id, null: false            # 会員ID
      t.string :title                                # タイトル
      t.string :author                               # 著者
      # isbn部分にnull: false, primary_key: trueを追記し、主キーとして扱う
      t.bigint :isbn, null: false, primary_key: true # ISBN
      t.string :url                                  # 楽天ブックスURL
      t.string :image_url                            # 画像URL
      t.integer :progress                            # 進捗度

      t.timestamps
    end
  end
end
