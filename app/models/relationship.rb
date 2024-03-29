class Relationship < ApplicationRecord
  # Followerモデルの参照が来たら、Userモデルを参照するように指定
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true, uniqueness: { scope: :followed_id }
  validates :followed_id, presence: true
end