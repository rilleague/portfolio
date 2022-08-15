class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  extend CarrierWave::Mount
  belongs_to_active_hash :age
  mount_uploader :avatar, AvatarUploader
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  # (フォローする側から、)中間テーブルを通して、フォローされる側を取得する
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # (フォローされる側から、)中間テーブルを通して、フォローしてくる側を取得する
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 中間テーブルを通してfollowedモデルのフォローされる側を取得すること
  has_many :following_user, through: :follower, source: :followed  #自分がフォローしている人
  # 中間テーブルを通してfollowerモデルのフォローする側を取得すること
  has_many :follower_user, through: :followed, source: :follower   #自分をフォローしている人


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    # 半角英数字でないと保存出来ない
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX, on: :create
    # 同じニックネームは保存出来ない且つ6文字以内
    validates :nickname, uniqueness: true, length: { maximum: 8 }
  end
  validates :introduction, length: { maximum: 300 }

  def favorite_find?(post_id)
    # favoritesテーブルにpost_idが存在しているかを探す
    favorites.where(post_id: post_id).exists?
  end

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返り値で渡す
  def following?(user)
    following_user.include?(user)
  end
end