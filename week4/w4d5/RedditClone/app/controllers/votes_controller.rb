class VotesController < ApplicationController
  def create
    @post = Post.find(params[:id])
    @post.votes.create!(value: params[:value], user_id: current_user.id)
    redirect_to post_url(@post)
  end
end
