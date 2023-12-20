class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find(user_id)
    @posts = @user.recent_posts
  end
end
