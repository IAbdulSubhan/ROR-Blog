class CommentsController < ApplicationController
  before_action :set_post



  def create
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_to @post, notice: 'Your comment was successfully posted.'
    else
      render 'posts/show', alert: 'There was an error posting your comment.'
    end
  end

  def reply
    @parent_comment = Comment.find(params[:parent_comment_id])
    @comment = @parent_comment.children.build(comment_params)
    if @comment.save
      redirect_to @post, notice: 'Your reply was posted successfully.'
    else
      render 'posts/show', alert: 'There was an error posting your reply.'
    end
  end


  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_comment_path(@post, @comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: post_comment_path(@post, @comment) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @post, notice: "Comment was successfully deleted." }
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@comment)
      end
    end



  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
