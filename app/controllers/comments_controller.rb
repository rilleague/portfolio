class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      redirect_to post_path(@post), notice: 'コメントを投稿しました'
    else
      render "posts/show"
    end
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id]), alert: 'コメントを削除しました'
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
