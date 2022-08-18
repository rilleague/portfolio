class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # １人が１つの投稿に対して、１回しかいいねを付けられないように設定
  validates :post_id, uniqueness: { scope: :user_id }, presence: true
  validates :user_id, presence: true
end
