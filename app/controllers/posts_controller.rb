class PostsController < ApplicationController
  before_action :require_sign_in, except: :show
  before_action :find_topic, only: [:new, :create]
  before_action :find_post, only: [:edit, :update, :show, :destroy]
  before_action :authorize_user_new_create, only: [:new, :create]
  before_action :authorize_user_edit_update, only: [:edit, :update]
  before_action :authorize_user_delete, only: :destroy


  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def authorize_user_new_create
    unless current_user.member?
      flash[:alert] = "You do not have sufficient privileges to do that."
      redirect_to topics_path
    end
  end

  def authorize_user_edit_update
    unless current_user == @post.user || (current_user.admin? || current_user.moderator?)
      flash[:alert] = "You must be an admin to do that."
      redirect_to [@post.topic, @post]
    end
  end

  def authorize_user_delete
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to topics_path
    end
  end
end
