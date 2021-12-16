class Api::V1::CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    id = params[:post_id]
    @comments = Comment.where({ post_id: id }).order(:created_at)
    render json: { data: { comments: @comments } }, status: :ok
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(text: comment_parameters[:text], author_id: current_user.id, post_id: @post.id)
    if @comment.save
      render json: @comment
    else
      render error: { error: 'Unable to create comments' }, status: 400
    end
  end

  private

  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
