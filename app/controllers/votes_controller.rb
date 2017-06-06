class VotesController < ApplicationController
  before_action :make_vote

  def up_vote
    submit_vote!(1)
    # redirect_to :back
  end

  def down_vote
    submit_vote!(-1)
    # redirect_to :back
  end

  private
  def make_vote
    @post = Post.find(params[:post_id])
    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def submit_vote!(value)
    if @vote
      authorize @vote, :update?
      @vote.update_attribute(:value, value)
    else
      @vote = current_user.votes.build(value: value, post: @post)
      authorize @vote, :create?
      @vote.save
    end
  end
    
end