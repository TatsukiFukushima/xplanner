class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :set_comment, only: :destroy
  before_action :correct_user_for_comment, only: :destroy
  
  
  def index 
    if params[:long_term_goal_id]
      @long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
      @comments = @long_term_goal.comments 
    elsif params[:mid_term_goal_id]
      @mid_term_goal = MidTermGoal.find(params[:mid_term_goal_id])
      @comments = @mid_term_goal.comments 
    elsif params[:short_term_goal_id] 
      @short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
      @comments = @short_term_goal.comments 
    elsif params[:approach_id] 
      @approach = Approach.find(params[:approach_id])
      @comments = @approach.comments
    end 
  end 
  
  def l_create 
    @long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
    @comment = @long_term_goal.comments.build(comment_params)
    if @comment.save
      flash[:success] = "コメントを送信しました"
      notice = Notice.new(from_id: current_user.id, to_id: @long_term_goal.user_id, 
              content: "#{current_user.name}さんがあなたの長期目標(#{@long_term_goal.content})にコメントしました", link_to: "/long_term_goals/#{@long_term_goal.id}/comments")
      notice.save
      redirect_to long_term_goal_comments_path(@long_term_goal)
    else 
      flash[:info] = "コメントの送信ができませんでした"
      redirect_to long_term_goal_comments_path(@long_term_goal)
    end 
  end 
  
  def m_create
    @mid_term_goal = MidTermGoal.find(params[:mid_term_goal_id])
    @long_term_goal = LongTermGoal.find(@mid_term_goal.long_term_goal_id)
    @comment = @mid_term_goal.comments.create(comment_params)
    if @comment.save
      flash[:success] = "コメントを送信しました"
      notice = Notice.new(from_id: current_user.id, to_id: @long_term_goal.user_id, 
              content: "#{current_user.name}さんがあなたの中期目標(#{@mid_term_goal.content})にコメントしました", link_to: "/mid_term_goals/#{@mid_term_goal.id}/comments")
      notice.save
      redirect_to mid_term_goal_comments_path(@mid_term_goal)
    else 
      flash[:info] = "コメントの送信ができませんでした"
      redirect_to mid_term_goal_comments_path(@mid_term_goal)
    end 
  end 
  
  def s_create 
    @short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
    @mid_term_goal = MidTermGoal.find(@short_term_goal.mid_term_goal_id)
    @long_term_goal = LongTermGoal.find(@mid_term_goal.long_term_goal_id)
    @comment = @short_term_goal.comments.create(comment_params)
    if @comment.save
      flash[:success] = "コメントを送信しました"
      notice = Notice.new(from_id: current_user.id, to_id: @long_term_goal.user_id, 
              content: "#{current_user.name}さんがあなたの短期目標(#{@short_term_goal.content})にコメントしました", link_to: "/short_term_goals/#{@short_term_goal.id}/comments")
      notice.save
      redirect_to short_term_goal_comments_path(@short_term_goal)
    else 
      flash[:info] = "コメントの送信ができませんでした"
      redirect_to short_term_goal_comments_path(@short_term_goal)
    end 
  end 
  
  def a_create 
    @approach = Approach.find(params[:approach_id])
    @short_term_goal = ShortTermGoal.find(@approach.short_term_goal_id)
    @mid_term_goal = MidTermGoal.find(@short_term_goal.mid_term_goal_id)
    @long_term_goal = LongTermGoal.find(@mid_term_goal.long_term_goal_id)
    @comment = @approach.comments.create(comment_params)
    if @comment.save
      flash[:success] = "コメントを送信しました"
      notice = Notice.new(from_id: current_user.id, to_id: @long_term_goal.user_id, 
              content: "#{current_user.name}さんがあなたのアプローチ(#{@approach.content})にコメントしました", link_to: "/approaches/#{@approach.id}/comments")
      notice.save
      redirect_to approach_comments_path(@approach)
    else 
      flash[:info] = "コメントの送信ができませんでした"
      redirect_to approach_comments_path(@approach)
    end 
  end 
  
  def destroy
    @comment.destroy 
    flash[:success] = "コメントを削除しました"
    redirect_to request.referer
  end

  private 
  
    def comment_params
      params.require(:comment).permit(:content, :user_id)
    end
    
    
    # beforeアクション
  
    def set_comment
      @comment = Comment.find(params[:id])
    end 
    
    def correct_user_for_comment
      redirect_to(root_url) unless current_user?(@comment.user)
    end
end
