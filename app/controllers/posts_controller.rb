class PostsController < ApplicationController
  load_and_authorize_resource

  skip_authorize_resource only: [:all_posts]

  def index
    @user = User.includes(:posts).find_by(id: params[:user_id])
    @posts = @user.recent_posts
  end

  def show
    @user = User.find_by(id: params[:user_id])
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

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to user_posts_path(@post.author_id), notice: 'Post has been successfully deleted!'
    else
      redirect_to user_post_path(@post.user.id, @post.id), alert: 'Post not deleted. Please try again!'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
