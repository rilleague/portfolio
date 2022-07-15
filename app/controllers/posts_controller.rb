class PostsController < ApplicationController
  def new
    @post = Post.new
    @post.post_tags.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :category_id, :part_id, :skin_id, :detail, { tag_ids: [] }, { images: [] }).merge(user_id: current_user.id)
  end
end
