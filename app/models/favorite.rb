class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # １人が１つの投稿に対して、１回しかいいねを付けられないように設定
  validates_uniqueness_of :post_id, scope: :user_id
end
