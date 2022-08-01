class Relationship < ApplicationRecord
  # Followerモデルの参照が来たら、Userモデルを参照するように指定
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
end