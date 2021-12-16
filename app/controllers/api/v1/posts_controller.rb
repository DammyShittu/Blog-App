class Api::V1::PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.order(:created_at)
    render json: { data: {posts: @posts} }, status: :ok
  end
end
