class CommentRepliesController < ApplicationController
  before_action :logged_in_user
  before_action :set_comment_reply, only: :destroy 
  before_action :reply_set_comment, only: [:create, :index]
  before_action :correct_user_for_comment_reply, only: :destroy 
  
  
  def index 
    @comment_replies = @comment.comment_replies 
  end 
  
  def create 
    @comment_reply = @comment.comment_replies.build(comment_reply_params)
    if @comment_reply.save 
      flash[:success] = "返信コメントを送信しました"
      redirect_to request.referer
    else 
      flash[:info] = "返信コメントの送信ができませんでした"
      redirect_to request.referer
    end 
  end 
  
  def destroy 
    @comment_reply.destroy 
    flash[:success] = "返信コメントを削除しました"
    redirect_to request.referer 
  end 
  
  
  private 
  
    def comment_reply_params
      params.require(:comment_reply).permit(:content, :user_id)
    end 
    
    # beforeアクション
    
    def reply_set_comment
      @comment = Comment.find(params[:comment_id])
    end 
    
    def set_comment_reply
      @comment_reply = CommentReply.find(params[:id])
    end 
    
    def correct_user_for_comment_reply
      redirect_to(root_url) unless current_user?(@comment_reply.user)
    end 
end
