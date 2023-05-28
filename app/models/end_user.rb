class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 画像投稿
  has_one_attached :profile_image

  # 学習記録詳細
  has_many :learning_records
  # 質問
  has_many :questions
  # 回答
  has_many :answers
  # コメント
  has_many :comments
  # いいね
  has_many :favorites
  # 参考書
  has_many :reference_books

  enum is_study: {learning: 0, learning_retake: 1, pass: 2}

  validates :account_name, presence: true  # presence: trueで入力済みかを検証
  # emailは基本的にpresence: true, uniqueness: trueがかかっているから記述の必要なし
  # validates :email, presence: true, uniqueness: true  # uniqueness:trueでテーブル全体での重複を防ぐ(一つの名前のラベル名しか保存できないようにする)
  validates :is_study, presence: true
  # 編集の時だけバリデーションの対象にするためにupdateメソッドのみ指定
  # nilを許さないのでコメントアウト
  # validates :exam_date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/}, on: :update  # 日付の正規表(YYYY-MM-DD)

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_logo.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
