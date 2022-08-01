class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @posts = @user.posts
    @favorite_count = 0
    @posts.each do |post|
      @favorite_count += post.favorites.count
    end
    @post1 = Post.where(category_id: "2", user_id: @user.id).order("created_at DESC")
    @post2 = Post.where(category_id: "3", user_id: @user.id).order("created_at DESC")
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "プロフィールを更新しました"
    else
      flash.now['danger'] = "プロフィールを更新出来ませんでした"
      render :edit
    end
  end

  # 自分がフォローしているユーザーを表示するメソッドを定義
  def follows
    user = User.find(params[:id])
    @users = user.following_user.order("created_at DESC")
  end

  # 自分をフォローしているユーザーを表示するメソッドを定義
  def followers
    user = User.find(params[:id])
    @users = user.follower_user.order("created_at DESC")
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :age_id, :introduction, :avatar)
  end
end
