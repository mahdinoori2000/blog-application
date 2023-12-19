class PostsController < ApplicationController
  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
    @posts = Post.includes(:author, :comments).where(author_id: params[:user_id])
  end

  def show
    user_id = params[:user_id]
    @user = User.find(user_id)
    @post = Post.includes(:author, :comments, :likes).find(params[:id])
  end

  def new
    @current_user = current_user
    @post = @current_user.posts.new
  end

  def create
    @current_user = current_user
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_post_url(@current_user, @post)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
