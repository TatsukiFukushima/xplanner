class LikesController < ApplicationController
  before_action :set_like, only: [:l_destroy, :m_destroy, :s_destroy, :a_destroy] 
  before_action :logged_in_user
  
  
  
  def l_create
    @long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
    @like = @long_term_goal.likes.create(user_id: current_user.id)
  end
  
  def m_create 
    @mid_term_goal = MidTermGoal.find(params[:mid_term_goal_id])
    @like = @mid_term_goal.likes.create(user_id: current_user.id)
  end 
  
  def s_create 
    @short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
    @like = @short_term_goal.likes.create(user_id: current_user.id)
  end 
  
  def a_create 
    @approach = Approach.find(params[:approach_id])
    @like = @approach.likes.create(user_id: current_user.id)
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
