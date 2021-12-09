class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(text: comment_parameters[:text], author_id: current_user.id, post_id: @post.id)

    respond_to do |format|
      format.html do
        if @comment.save
          redirect_to user_post_path(@post.author_id, @post.id), notice: "Comment saved successfully"
        else
          redirect_to user_post_path(@post.author_id, @post.id), alert: "Error, Comment not created!"
        end
      end
    end
  end

  private
  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
