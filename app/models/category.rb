class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択して下さい' },
    { id: 2, name: '美容投稿' },
    { id: 3, name: 'お悩み投稿' }
  ]

  include ActiveHash::Associations
  has_many :posts
end