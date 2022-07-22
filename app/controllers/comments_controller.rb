class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(@comment.post)
    else
      @comments = @post.comments.includes(:user)
      render "posts/#{@post.id}"
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:content).merge(post_id: params[:post_id], user_id: current_user.id)
  end
end
