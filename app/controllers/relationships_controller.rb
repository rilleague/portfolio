class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_relationship

  # フォローする
  def create
    @relationship = current_user.follow(params[:user_id])
  end

  # フォロー解除する
  def destroy
    @relationship = current_user.unfollow(params[:user_id])
  end

  private

  def set_relationship
    @user = User.find(params[:user_id])
  end
end