class Post < ApplicationRecord
  belongs_to :user
  mount_uploaders :images, ImageUploader
  has_many :tags, through: :post_tags
  has_many :post_tags, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :part
  belongs_to :skin

  with_options presence: true do 
    validates :title
    validates :category_id, numericality: { other_than: 1, message: "can't be blank"}
    validates :detail
  end
  validates :part_id, numericality: { other_than: 1, message: "can't be blank" } 
  validates :skin_id, numericality: { other_than: 1, message: "can't be blank" } 
end
