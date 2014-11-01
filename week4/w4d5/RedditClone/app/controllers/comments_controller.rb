class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @comment.parent_comment_id = params[:parent_comment_id]
    render :new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.parent_comment_id = params[:comment][:parent_comment_id]
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @comment.errors.full_messages
      @post = Post.find(params[:comment][:post_id])
      render :new
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
