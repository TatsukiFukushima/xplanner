class MidTermGoalsController < ApplicationController
  before_action :set_mid_term_goal, only: [:edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user_for_m_goal, only: [:new, :create, :edit, :update, :destroy]
  
  
  
  def new
    @long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
    @mid_term_goal = @long_term_goal.mid_term_goals.build
  end
  
  def create 
    @long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
    @mid_term_goal = @long_term_goal.mid_term_goals.build(mid_term_goal_params)
    if @mid_term_goal.save
      flash[:success] = "中期目標を作成しました"
      redirect_to long_term_goal_mid_term_goals_path(@long_term_goal)
    else 
      render 'new'
    end
  end 

  def index
    @long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
    @user = @long_term_goal.user 
    @mid_term_goals = @long_term_goal.mid_term_goals.rank(:row_order)
  end

  def edit
  end
  
  def update 
    @long_term_goal = @mid_term_goal.long_term_goal
    if @mid_term_goal.update_attributes(mid_term_goal_params)
      flash[:success] = "中期目標を編集しました"
      redirect_to long_term_goal_mid_term_goals_path(@long_term_goal)
    else 
      render 'edit'
    end 
  end 
  
  def destroy 
    @long_term_goal = @mid_term_goal.long_term_goal
    @mid_term_goal.destroy 
    flash[:success] = "中期目標を削除しました"
    redirect_to long_term_goal_mid_term_goals_path(@long_term_goal)
  end 
  
  
  # 並び替えのデータ（row_order_position）を更新するメソッド
  #（正しいユーザーがドラッグアンドドロップした時のみ）
  def sort 
    mid_term_goal = MidTermGoal.find(params[:mid_term_goal_id])
    long_term_goal = mid_term_goal.long_term_goal
    @user = long_term_goal.user
    if @user == current_user
      mid_term_goal.update(mid_term_goal_params)
      render body: nil
    end
  end 

  
  
  private 
  
    def set_mid_term_goal
      @mid_term_goal = MidTermGoal.find(params[:id])
    end 
    
    def mid_term_goal_params
      params.require(:mid_term_goal).permit(:content, :row_order_position)
    end 
    
    
    # beforeアクション
    
    # 正しいユーザーかどうか確認
    def correct_user_for_m_goal
      if params[:long_term_goal_id]
        @long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
        @user = @long_term_goal.user 
      else
        @long_term_goal = @mid_term_goal.long_term_goal 
        @user = @long_term_goal.user 
      end 
      redirect_to(root_url) unless current_user?(@user)
    end 
end
