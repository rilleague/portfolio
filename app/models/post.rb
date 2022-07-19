class Post < ApplicationRecord
  belongs_to :user
  mount_uploaders :images, ImageUploader
  serialize :images, JSON
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :part
  belongs_to :skin
end
