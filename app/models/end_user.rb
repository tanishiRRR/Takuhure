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

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_logo.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
