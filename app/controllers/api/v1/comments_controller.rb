class Api::V1::CommentsController < ApplicationController
    before_action :set_json_api_content_type

    def index
      user = User.find(params[:user_id])
      post = user.posts.find(params[:post_id])
      comments = post.comments
      render json: comments, status: :ok
    end
  
    def create
      user = User.find(params[:user_id])
      post = user.posts.find(params[:post_id])
      comment = post.comments.new(comment_params)
      comment.user = user
  
      if comment.save
        render json: comment, status: :created
      else
        render json: comment.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_json_api_content_type
      response.headers['Content-Type'] = 'application/vnd.api+json'
    end
  
    def comment_params
      params.require(:comment).permit(:text)
    end
end
