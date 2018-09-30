class LongTermGoalsController < ApplicationController
  before_action :set_long_term_goal, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user 
  before_action :correct_user_for_l_goal, only: [:new, :create, :edit, :update, :destroy]

  
  
  def new
    @user = User.find(params[:user_id])
    @long_term_goal = @user.long_term_goals.build
  end

  def create
    @user = User.find(params[:user_id]) 
    @long_term_goal = @user.long_term_goals.build(long_term_goal_params)
    if @long_term_goal.save 
      flash[:success] = "長期目標を作成しました"
      redirect_to user_long_term_goals_path
    else 
      render 'new'
    end 
  end
  
  def index 
    @user = User.find(params[:user_id])
    @long_term_goals = @user.long_term_goals.rank(:row_order)
  end 

  def edit
  end

  def update
    if @long_term_goal.update_attributes(long_term_goal_params)
      flash[:success] = "長期目標を編集しました"
      redirect_to user_long_term_goals_path(current_user)
    else
      render 'edit'
    end 
  end

  def destroy
    @long_term_goal.destroy
    flash[:success] = "長期目標を削除しました"
    redirect_to user_long_term_goals_path(current_user)
  end
  
  # 並び替えのデータ（row_order_position）を更新するメソッド
  #（正しいユーザーがドラッグアンドドロップした時のみ）
  def sort 
    long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
    @user = long_term_goal.user
    if @user == current_user
      long_term_goal.update(long_term_goal_params)
      render body: nil
    end
  end 
  
  
  private 
  
    def set_long_term_goal
      @long_term_goal = LongTermGoal.find(params[:id])
    end 
  
    def long_term_goal_params
      params.require(:long_term_goal).permit(:category, :content, :row_order_position)
    end 
    
    
    # beforeアクション
    
    # 正しいユーザーかどうか確認
    def correct_user_for_l_goal 
      if params[:user_id]
        @user = User.find(params[:user_id])
      else 
        @user = @long_term_goal.user
      end
      redirect_to(root_url) unless current_user?(@user)
    end 
    

end
