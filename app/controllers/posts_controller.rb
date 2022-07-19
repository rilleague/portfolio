class PostsController < ApplicationController
  def index
    @category_id = params[:category_id]
    if params[:category_id] == "2"
      @posts =  Post.where(category_id: 2).order("created_at DESC")
    else
      @posts =  Post.where(category_id: 3).order("created_at DESC")
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

  private
  def post_form_params
    params.require(:post_form).permit(:title, :category_id, :part_id, :skin_id, :detail, :tagname, { images: [] }).merge(user_id: current_user.id)
  end
end
