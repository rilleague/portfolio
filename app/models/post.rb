class Post < ApplicationRecord
  belongs_to :user
  mount_uploaders :images, ImageUploader
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :part
  belongs_to :skin
end
