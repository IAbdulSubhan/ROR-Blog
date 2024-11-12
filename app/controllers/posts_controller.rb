class PostsController < ApplicationController
  include ApplicationHelper
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_non_admin_users, only: [:index]

  

  # GET /posts or /posts.json
  # def index
  #   if params[:user_id]
  #     @user = User.find_by(id: params[:user_id])
  #     if @user
  #       @pagy, @posts = pagy(@user.posts)
  #     else
  #       flash[:alert] = "User not found"
  #       @pagy, @posts = pagy(Post.all, items: 5)
  #     end
  #   elsif params[:catagory_id]
  #     @catagory = Catagory.find_by(id: params[:catagory_id])
  #     if @catagory
  #       @pagy, @posts = pagy(@catagory.posts)
  #     else
  #       flash[:alert] = "Category not found"
  #       @pagy, @posts = pagy(Post.all, items: 5)
  #     end
  #   else
  #     if user_signed_in?
  #       if current_user.admin?
  #         @pagy, @posts = pagy(Post.all, items: 5)
  #       else
  #         @pagy, @posts = pagy(current_user.posts)
  #       end
  #     else
  #       @pagy, @posts = pagy(Post.all, items: 5)
  #     end
  #   end
  # end
  def index
    # @q = Post.ransack(params[:q])
    # @post = @q.result(distinct: true)
    #

    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user
        @pagy, @posts = pagy(@user.posts, items: 3) # Set items per page to 3
      else
        flash[:alert] = "User not found"
        @pagy, @posts = pagy(Post.all, items: 3) # Default to 3 items
      end
    elsif params[:catagory_id]
      @catagory = Catagory.find(params[:catagory_id])
      @pagy, @posts = pagy(@catagory.posts, items: 3)
    else
      if user_signed_in?
        if current_user.admin?
          @pagy, @posts = pagy(Post.all, items: 3) # Default to 3 items for admin
        else
          @pagy, @posts = pagy(current_user.posts, items: 3)
        end
      else
        @pagy, @posts = pagy(Post.all, items: 3) # Default to 3 items for guests
      end
    end
  end
  
  def expand_overview
    @post = Post.find(params[:id])
    render partial: "post_card", locals: { post: @post }
  end
  

  def user_posts
    @users = User.find(params[:id])
    @posts = @users.posts
  end

  def landingpage
    
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # For regular requests
      format.turbo_stream # For Turbo Frame requests
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user=current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_body }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body,:overview ,:cover_image, :status, :catagory_id,)
    end


    def set_non_admin_users
      @non_admin_users = User.where(admin: false)
    end



    
end
