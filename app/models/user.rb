class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  extend CarrierWave::Mount
  belongs_to_active_hash :age
  mount_uploader :avatar, AvatarUploader
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  # Userがたくさんの人をフォローしている
  has_many :following_relationships, class_name: "Relationships", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following
  # Userがたくさんのフォロワーにフォローされている
  has_many :follower_relationships, class_name: "Relationships", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    # 半角英数字でないと保存出来ない
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX, on: :create
    # 同じニックネームは保存出来ない
    validates :nickname, uniqueness: true, length: { maximum: 6 }
  end
  validates :age_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :introduction, length: { maximum: 300 }

  def favorite_find?(post_id)
    # favoritesテーブルにpost_idが存在しているかを探す
    favorites.where(post_id: post_id).exists?
  end

  # フォローした時の処理
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  # フォローを外した時の処理
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  # フォローをしているか判定する処理
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end
end
