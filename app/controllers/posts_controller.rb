class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find_by(id: params[:user_id])
    @posts = @user.recent_posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments, :likes).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      format.html do
        if @post.save
          redirect_to user_post_path(@post.author_id, @post.id), notice: 'Post has been successfully created!'
        else
          render :new, alert: 'Post not created. Please try again!'
        end
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
