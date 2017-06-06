class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = Comment.new
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(user_params)
    @comment.post = @post
    @topic = @post.topic
    authorize @comment
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      redirect_to [@post.topic, @post]
    end
  end

  # def edit
  #   @post = Post.find(params[:id])
  #   @topic = @post.topic
  #   authorize @post
  # end

  # def update
  #   @post = Post.find(params[:id])
  #   @topic = @post.topic
  #   authorize @post
  #   if @post.update_attributes(user_params)
  #     flash[:notice] = "Post was updated."
  #     redirect_to [@topic, @post]
  #   else
  #     flash[:error] = "There was an error saving the post. Please try again."
  #     render :edit
  #   end
  # end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    topic = post.topic
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment deleted."
      redirect_to [topic, post]
    else
      flash[:error] = "Error deleting comment. Please try again."
      render :show
    end
  end

  private def user_params
    params.require(:comment).permit(:body)
  end
end
