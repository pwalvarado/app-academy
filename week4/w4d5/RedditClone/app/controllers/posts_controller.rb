class PostsController < ApplicationController
  before_action :ensure_logged_in, except: :show
  before_action :ensure_post_creator, only: [:edit, :update]
  
  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end
  
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_ids = params[:post][:sub_ids]
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @post.errors.full_messages
      @subs = Sub.all
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
    # @top_level_comments = Comment
    #   .where('post_id = ?', @post.id)
    #   .where('parent_comment_id IS NULL')
    #
    # @all_comments = @post.comments
    #
    @comments_by_parent_id = @post.comments_by_parent_id
    render :show
  end
  
  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end
  
  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @post.errors.full_messages
      render :edit
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
  
  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end
  
  def ensure_post_creator
    post = Post.find(params[:id])
    if current_user.id != post.author_id
      flash[:errors] ||= []
      flash[:errors] << "You can only edit your own post!"
      redirect_to post_url(post)
    end
  end
end
