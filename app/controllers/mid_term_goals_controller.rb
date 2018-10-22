class MidTermGoalsController < ApplicationController
  before_action :m_set_mid_term_goal, only: [:edit, :update, :destroy]
  before_action :m_set_long_term_goal, only: [:new, :create, :index]
  before_action :logged_in_user
  before_action :m_correct_user, except: [:sort, :index]
  
  
  
  def new
    @mid_term_goal = @long_term_goal.mid_term_goals.build
    @mid_term_goal.build_deadline
  end
  
  def create 
    @mid_term_goal = @long_term_goal.mid_term_goals.build(mid_term_goal_params)
    if @mid_term_goal.save
      @mid_term_goals = @long_term_goal.mid_term_goals.rank(:row_order)
      # flash[:success] = "中期目標を作成しました"
    else 
      render 'new'
    end
  end 

  def index
    @user = @long_term_goal.user 
    @mid_term_goals = @long_term_goal.mid_term_goals.rank(:row_order)
  end

  def edit
  end
  
  def update 
    @long_term_goal = @mid_term_goal.long_term_goal
    if @mid_term_goal.update_attributes(mid_term_goal_params)
      @mid_term_goals = @long_term_goal.mid_term_goals.rank(:row_order)
      # flash[:success] = "中期目標を編集しました"
    else 
      render 'edit'
    end 
  end 
  
  def destroy 
    @long_term_goal = @mid_term_goal.long_term_goal
    @mid_term_goal.destroy 
    @mid_term_goals = @long_term_goal.mid_term_goals.rank(:row_order)
    # flash[:success] = "中期目標を削除しました"
  end 
  
  
  # 並び替えのデータ（row_order_position）を更新するメソッド
  #（正しいユーザーがドラッグアンドドロップした時のみ更新する）
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
  
    def mid_term_goal_params
      params.require(:mid_term_goal).permit(:user_id, :content, :row_order_position, :status,
        deadline_attributes: :date)
    end 
    
    
    # beforeアクション
    
    # 長期目標をurlのパラメーターからセットする
    def m_set_long_term_goal
      @long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
    end 
    
    # 中期目標をurlのパラメーターからセットする
    def m_set_mid_term_goal
      @mid_term_goal = MidTermGoal.find(params[:id])
    end 
    
    # 正しいユーザーかどうか確認
    def m_correct_user
      if params[:long_term_goal_id]
        @user = @long_term_goal.user 
      else
        @long_term_goal = @mid_term_goal.long_term_goal 
        @user = @long_term_goal.user 
      end 
      redirect_to(root_url) unless current_user?(@user)
    end 
end
