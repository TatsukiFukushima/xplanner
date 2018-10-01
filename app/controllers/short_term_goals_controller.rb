class ShortTermGoalsController < ApplicationController
  before_action :set_short_term_goal, only: [:edit, :update, :destroy]
  before_action :logged_in_user 
  before_action :correct_user_for_s_goal, except: [:sort, :index] 
  


  def new
    @mid_term_goal = MidTermGoal.find(params[:mid_term_goal_id])
    @short_term_goal = @mid_term_goal.short_term_goals.build 
  end
  
  def create 
    @mid_term_goal = MidTermGoal.find(params[:mid_term_goal_id])
    @short_term_goal = @mid_term_goal.short_term_goals.build(short_term_goal_params)
    @long_term_goal = @mid_term_goal.long_term_goal 
    if @short_term_goal.save
      flash[:success] = "短期目標を作成しました"
      redirect_to mid_term_goal_short_term_goals_path(@mid_term_goal)
    else 
      render 'new'
    end 
  end
  
  def index
    @mid_term_goal = MidTermGoal.find(params[:mid_term_goal_id])
    @long_term_goal = @mid_term_goal.long_term_goal 
    @user = @long_term_goal.user 
    @short_term_goals = @mid_term_goal.short_term_goals.rank(:row_order)
  end  

  def edit
  end
  
  def update 
    @mid_term_goal = @short_term_goal.mid_term_goal 
    @long_term_goal = @mid_term_goal.long_term_goal 
    if @short_term_goal.update_attributes(short_term_goal_params)
      flash[:success] = "短期目標を編集しました"
      redirect_to mid_term_goal_short_term_goals_path(@mid_term_goal)
    else 
      render 'edit'
    end 
  end 
  
  def destroy 
    @mid_term_goal = @short_term_goal.mid_term_goal
    @long_term_goal = @mid_term_goal.long_term_goal 
    @short_term_goal.destroy 
    flash[:success] = "短期目標を削除しました"
    redirect_to mid_term_goal_short_term_goals_path(@mid_term_goal)
  end 
  
  
  # 並び替えのデータ（row_order_position）を更新するメソッド
  #（正しいユーザーがドラッグアンドドロップした時のみ）
  def sort 
    short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
    long_term_goal = short_term_goal.mid_term_goal.long_term_goal 
    @user = long_term_goal.user 
    if @user == current_user 
      short_term_goal.update(short_term_goal_params)
      render body: nil 
    end 
  end 
  
  private 
  
    def set_short_term_goal
      @short_term_goal = ShortTermGoal.find(params[:id])
    end 
    
    def short_term_goal_params 
      params.require(:short_term_goal).permit(:content, :row_order_position, :status)
    end 
    
    
    # beforeアクション
    
    # 正しいユーザーかどうか確認
    def correct_user_for_s_goal
      if params[:mid_term_goal_id]
        @mid_term_goal = MidTermGoal.find(params[:mid_term_goal_id])
        @long_term_goal = @mid_term_goal.long_term_goal
        @user = @long_term_goal.user 
      else 
        @mid_term_goal = @short_term_goal.mid_term_goal 
        @long_term_goal = @mid_term_goal.long_term_goal 
        @user = @long_term_goal.user 
      end 
      redirect_to(root_url) unless current_user?(@user)
    end 
end
