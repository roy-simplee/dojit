class CommentsController < ApplicationController
  respond_to :html, :js

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(user_params)
    @comment.post = @post
    authorize @comment
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    topic = post.topic
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment deleted."
    else
      flash[:error] = "Error deleting comment. Please try again."
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [topic, @post] }
    end
  end

  private def user_params
    params.require(:comment).permit(:body)
  end
end
