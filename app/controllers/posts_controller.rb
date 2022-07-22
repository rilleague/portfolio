class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :show]

  def index
    @category_id = params[:category_id]
    if @category_id == "2" or @category_id == "3"
      @posts =  Post.where(category_id: @category_id).order("created_at DESC")
    else
      redirect_to root_path
    end
  end

  def new
    @post = PostForm.new
  end

  def create
    @post = PostForm.new(post_form_params)
    tag_list = params[:post_form][:tagname].split(',')
    if @post.valid?
      # valid?している理由は、PostFormクラスがApplicationRecordを継承していない事により、saveメソッドがバリデーションを実行する機能を持っていない為
      @post.save(tag_list)
      redirect_to "/posts?category_id=#{params[:post_form][:category_id]}"
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    # 各カラムの中に、paramsで受け取った投稿の中身を入れる
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tagname).join(",")
    @form = PostForm.new(title: @post.title, category_id: @post.category_id, part_id: @post.part_id, skin_id: @post.skin_id, detail: @post.detail, images: @post.images )
  end

  def update
    @post = Post.find(params[:id])
    @form = PostForm.new(update_params)
    tag_list = params[:post_form][:tagname].split(",")
    if @form.valid?
      #下記のupadateは、post_form.rbにて定義しているupdateメソッドである。
      @form.update(tag_list)
      redirect_to post_path(post.id)
    else
      render :edit
    end
  end

  private
  def post_form_params
    params.require(:post_form).permit(:title, :category_id, :part_id, :skin_id, :detail, :tagname, { images: [] }).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:post_form).permit(:title, :category_id, :part_id, :skin_id, :detail, :tagname, { images: [] }).merge(user_id: current_user.id, post_id: params[:id])
  end
end