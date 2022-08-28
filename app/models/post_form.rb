class PostForm
  include ActiveModel::Model
  # PostFormオブジェクトが、PostモデルとTagモデルの属性を扱えるようにする
  attr_accessor :title, :images, :category_id, :part_id, :skin_id, :detail, :tagname, :user_id, :post_id, :tag_id
  # 下記でフォームのアクションをPUSHとPATCHに切り替える。
  delegate :persisted?, to: :post
  # コントローラーで定義したインスタンス変数を参照する為に、メソッドを定義
  attr_reader :post
  # 画像保存の枚数制限
  FILE_NUMBER_LIMIT = 3

  # PostモデルのバリデーションをFormオブジェクト内に移す
  with_options presence: true do 
    validates :title, length: { maximum: 80 }
    validates :category_id, numericality: { other_than: 1, message: "を入力してください"}
    validates :detail, length: { maximum: 400 }
  end
  validate :validates_number_of_files, if: -> { self.images.present? }

  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end

  def to_model
    post
  end

  # フォームから送られてきた投稿内容をテーブルに保存する処理を記述
  def save(tag_list)
    # Postモデルの属性を保存する
    @post.update(title: title, category_id: category_id, part_id: part_id, skin_id: skin_id, detail: detail, user_id: user_id, images: images)

    # @postに紐付くタグが有れば、post_tagsテーブルの該当するレコードを削除する
    @post.post_tags.each do |tag|
      tag.delete
    end

    # フォームから送られてきたタグ情報から、whereメソッドで検索した条件に一致するレコードがあれば、インスタンスとして返し無ければ生成する。
    tag_list.each do |tag_name|
      tag = Tag.where(tagname: tag_name).first_or_initialize
      tag.save
      # 中間テーブルの値を保存する
      PostTag.find_or_create_by(post_id: post.id, tag_id: tag.id) 
    end
  end

  def destroy
    form = Post.where(id: post_id)
    form.destroy
  end

  # 投稿画像の枚数制限に関するカスタムバリデーション
  def validates_number_of_files
    if self.images.length > FILE_NUMBER_LIMIT
      self.errors.add(:images, "に添付出来る画像は#{FILE_NUMBER_LIMIT}枚までです。")
      return false
    end
  end

  private

  def default_attributes
    {
      title: post.title,
      category_id: post.category_id,
      part_id: post.part_id,
      skin_id: post.skin_id,
      detail: post.detail,
      user_id: post.user_id,
      images: post.images,
    }
  end
end