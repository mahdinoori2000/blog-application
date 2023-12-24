class Api::V1::PostsController < ApplicationController
  before_action :set_json_api_content_type

  def index
    user = User.find(params[:user_id])
    posts = user.posts
    render json: posts, status: :ok
  end

  def show
    user = User.find(params[:user_id])
    post = user.posts.find(params[:id])
    render json: post, status: :ok
  end

  private

  def set_json_api_content_type
    response.headers['Content-Type'] = 'application/vnd.api+json'
  end
end
