class LikesController < ApplicationController
  before_action :set_like, only: [:l_destroy, :m_destroy, :s_destroy, :a_destroy] 
  before_action :logged_in_user
  
  
  def index 
    if params[:l_goal]
      @long_term_goal = LongTermGoal.find(params[:l_goal])
      @likes = @long_term_goal.likes 
    elsif params[:m_goal]
      @mid_term_goal = MidTermGoal.find(params[:m_goal])
      @likes = @mid_term_goal.likes 
    elsif params[:s_goal] 
      @short_term_goal = ShortTermGoal.find(params[:s_goal])
      @likes = @short_term_goal.likes 
    elsif params[:approach] 
      @approach = Approach.find(params[:approach])
      @likes = @approach.likes 
    end 
  end 
  
  def l_create
    @long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
    @like = @long_term_goal.likes.create(user_id: current_user.id)
    notice = Notice.new(from_id: current_user.id, to_id: @long_term_goal.user_id, 
              content: "#{current_user.name}さんがあなたの長期目標(#{@long_term_goal.content})にいいねしました", link_to: "/users/#{@long_term_goal.user_id}/long_term_goals")
    notice.save
  end
  
  def m_create 
    @mid_term_goal = MidTermGoal.find(params[:mid_term_goal_id])
    @long_term_goal = LongTermGoal.find(@mid_term_goal.long_term_goal_id)
    @like = @mid_term_goal.likes.create(user_id: current_user.id)
    notice = Notice.new(from_id: current_user.id, to_id: @long_term_goal.user_id, 
              content: "#{current_user.name}さんがあなたの中期目標(#{@mid_term_goal.content})にいいねしました", link_to: "/long_term_goals/#{@long_term_goal.id}/mid_term_goals")
    notice.save
  end 
  
  def s_create 
    @short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
    @mid_term_goal = MidTermGoal.find(@short_term_goal.mid_term_goal_id)
    @long_term_goal = LongTermGoal.find(@mid_term_goal.long_term_goal_id)
    @like = @short_term_goal.likes.create(user_id: current_user.id)
    notice = Notice.new(from_id: current_user.id, to_id: @long_term_goal.user_id, 
              content: "#{current_user.name}さんがあなたの短期目標(#{@short_term_goal.content})にいいねしました", link_to: "/mid_term_goals/#{@mid_term_goal.id}/short_term_goals")
    notice.save
  end 
  
  def a_create 
    @approach = Approach.find(params[:approach_id])
    @short_term_goal = ShortTermGoal.find(@approach.short_term_goal_id)
    @mid_term_goal = MidTermGoal.find(@short_term_goal.mid_term_goal_id)
    @long_term_goal = LongTermGoal.find(@mid_term_goal.long_term_goal_id)
    @like = @approach.likes.create(user_id: current_user.id)
    notice = Notice.new(from_id: current_user.id, to_id: @long_term_goal.user_id, 
              content: "#{current_user.name}さんがあなたのアプローチ(#{@approach.content})にいいねしました", link_to: "/mid_term_goals/#{@mid_term_goal.id}/short_term_goals")
    notice.save
  end 
  
  def l_destroy 
    @long_term_goal = @like.likable
    @like.destroy
  end 
  
  def m_destroy 
    @mid_term_goal = @like.likable
    @like.destroy
  end 
  
  def s_destroy 
    @short_term_goal = @like.likable 
    @like.destroy
  end 
  
  def a_destroy 
    @approach = @like.likable
    @like.destroy
  end 



  private 
  
    def set_like 
      @like = Like.find(params[:id])
    end 
end
