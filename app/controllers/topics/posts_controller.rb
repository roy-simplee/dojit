class Topics::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(page: params[:page], per_page: 10)
    @topic = @post.topic
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(user_params)
    @post.topic = @topic
    authorize @post
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @topic = @post.topic
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    @topic = @post.topic
    authorize @post
    if @post.update_attributes(user_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    topic = @post.topic
    title = @post.title
    authorize @post
    if @post.destroy
      flash[:notice] = "Post '#{title}' deleted."
      redirect_to topic
    else
      flash[:error] = "Error deleting post. Please try again."
      render :show
    end
  end

  private def user_params
    params.require(:post).permit(:title, :body)
  end
end
