class ApproachesController < ApplicationController
  before_action :set_approach, only: [:edit, :update, :destroy]
  before_action :logged_in_user 
  before_action :correct_user_for_approach, except: [:sort, :index]
  
  
  def new
    @short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
    @approach = @short_term_goal.approaches.build
    @approach.build_deadline
  end
  
  def create
    @short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
    @approach = @short_term_goal.approaches.build(approach_params)
    @mid_term_goal = @short_term_goal.mid_term_goal 
    if @approach.save 
      flash[:success] = "アプローチを作成しました"
      redirect_to mid_term_goal_short_term_goals_path(@mid_term_goal)
    else 
      render 'new'
    end 
  end 
  
  def index 
    @short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
    @approaches = @short_term_goal.approaches.rank(:row_order) 
  end 

  def edit
  end
  
  def update 
    @short_term_goal = @approach.short_term_goal 
    @mid_term_goal = @short_term_goal.mid_term_goal 
    if @approach.update_attributes(approach_params)
      flash[:success] = "アプローチを編集しました"
      redirect_to mid_term_goal_short_term_goals_path(@mid_term_goal)
    else 
      render 'new'
    end 
  end 
  
  def destroy 
    @short_term_goal = @approach.short_term_goal
    @mid_term_goal = @short_term_goal.mid_term_goal 
    @approach.destroy 
    flash[:success] = "アプローチを削除しました"
    redirect_to mid_term_goal_short_term_goals_path(@mid_term_goal)
  end  
  
  
  # 並び替えのデータ（row_order_position）を更新するメソッド
  #（正しいユーザーがドラッグアンドドロップした時のみ）
  def sort 
    approach = Approach.find(params[:approach_id])
    @user = approach.short_term_goal.mid_term_goal.long_term_goal.user 
    if @user == current_user 
      approach.update(approach_params)
      render body: nil 
    end 
  end 
  
  
  private 
  
    def set_approach
      @approach = Approach.find(params[:id])
    end 
    
    def approach_params 
      params.require(:approach).permit(:content, :row_order_position, :effectiveness,
        deadline_attributes: :date)
    end 
    
    # beforeアクション
    
    # 正しいユーザーかどうか確認
    def correct_user_for_approach
      if params[:short_term_goal_id]
        @short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
        @user = @short_term_goal.mid_term_goal.long_term_goal.user 
      else 
        @user = @approach.short_term_goal.mid_term_goal.long_term_goal.user 
      end 
      redirect_to(root_url) unless current_user?(@user)
    end 
end
