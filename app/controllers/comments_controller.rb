class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show new edit update destroy ] 
  before_action only: [:edit, :update, :destroy] do
  authorize_request(["admin"])
end

  # GET /comments or /comments.json
    # GET /comments or /comments.json
    def index
      @comments = Comment.all
      puts
      puts @comments
      puts
    end
  
    # GET /comments/1 or /comments/1.json
    def show
  
    end
  
    # GET /comments/new
    def new
      @comment = Comment.new
    end
  
    # GET /comments/1/edit
    def edit
    end
  
    # POST /comments or /comments.json
    def create
      @article = Article.find(params[:comment][:article_id])
      @comment = Comment.new(comment_params)
      @comment.user = current_user
      puts
      puts @comment
      puts
      respond_to do |format|
      if @comment.save
      format.html { redirect_to article_path(@article.id), notice:
      'Comment was successfully created.' }
      else
      format.html { redirect_to article_path(@article.id), notice:
      'Comment was not created.' }
      end
      end
      end
  
    # PATCH/PUT /comments/1 or /comments/1.json
    def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /comments/1 or /comments/1.json
    def destroy
      @comment.destroy
  
      respond_to do |format|
        format.html { redirect_to articles_url, notice: "Comment was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end
  
  
      # Only allow a list of trusted parameters through.
      def comment_params
        params.require(:comment).permit(:content, :article_id, :user_id, images:[]) 
      end
  end