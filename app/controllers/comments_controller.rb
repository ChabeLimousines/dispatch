class CommentsController < ApplicationController

  def index
    if params[:tag]
      @comments = Comment.order(created_at: :desc).page(params[:page]).per(50).tagged_with(params[:tag])
    else
      @comments = Comment.order(created_at: :desc).page(params[:page]).per(50)
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to action: :index, notice: 'Comment was successfully created.' }
        format.json { render :index, status: :created, location: @comments }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :tag_list, :author_list)
    end
end
