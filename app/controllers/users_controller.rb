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
    @relationship = Relationship.find_by(follower_id: current_user.id, followed_id: @user.id)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  # 自分がフォローしているユーザーを表示するメソッドを定義
  def follows
    user = User.find(params[:id])
    # user.rbでアソシエーションの記述following_userにより、フォローしているユーザー情報を持ってこれる
    @users = user.following_user.order("created_at DESC")
  end

  # 自分をフォローしているユーザーを表示するメソッドを定義
  def followers
    user = User.find(params[:id])
    # user.rbでアソシエーションの記述follower_userにより、フォローされているユーザー情報を持ってこれる
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
