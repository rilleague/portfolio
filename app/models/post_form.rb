class PostForm
  include ActiveModel::Model
  extend CarrierWave::Mount
  mount_uploaders :images, ImageUploader
  # PostFormオブジェクトが、PostモデルとTagモデルの属性を扱えるようにする
  attr_accessor :title, :images, :category_id, :part_id, :skin_id, :detail, :tagname, :user_id, :post_id, :tag_id

  # PostモデルのバリデーションをFormオブジェクト内に移す
  with_options presence: true do 
    validates :title
    validates :category_id, numericality: { other_than: 1, message: "can't be blank"}
    validates :detail
  end

  # フォームから送られてきた投稿内容をテーブルに保存する処理を記述
  def save(tag_list)
    # Postモデルの属性を保存する
    post = Post.create(title: title, category_id: category_id, part_id: part_id, skin_id: skin_id, detail: detail, user_id: user_id, images: images)
    # フォームから送られてきたタグ情報から、whereメソッドで検索した条件に一致するレコードがあれば、インスタンスとして返し無ければ生成する。
    tag_list.each do |tag_name|
      tag = Tag.where(tagname: tag_name).first_or_initialize
      tag.save
      # 中間テーブルの値を保存する
      PostTag.create(post_id: post.id, tag_id: tag.id) 
    end
  end
end