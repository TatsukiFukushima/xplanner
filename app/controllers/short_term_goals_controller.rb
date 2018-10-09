class ShortTermGoalsController < ApplicationController
  before_action :s_set_short_term_goal, only: [:edit, :update, :destroy]
  before_action :s_set_mid_term_goal, only: [:new, :create, :index]
  before_action :logged_in_user 
  before_action :s_correct_user, except: [:sort, :index] 
  


  def new
    @short_term_goal = @mid_term_goal.short_term_goals.build 
    @short_term_goal.build_deadline
  end
  
  def create 
    @short_term_goal = @mid_term_goal.short_term_goals.build(short_term_goal_params)
    @long_term_goal = @mid_term_goal.long_term_goal 
    if @short_term_goal.save
      @short_term_goals = @mid_term_goal.short_term_goals.rank(:row_order)
      # flash[:success] = "短期目標を作成しました"
    else 
      render 'new'
    end 
  end
  
  def index
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
      @short_term_goals = @mid_term_goal.short_term_goals.rank(:row_order)
      # flash[:success] = "短期目標を編集しました"
    else 
      render 'edit'
    end 
  end 
  
  def destroy 
    @mid_term_goal = @short_term_goal.mid_term_goal
    @long_term_goal = @mid_term_goal.long_term_goal 
    @short_term_goal.destroy 
    @short_term_goals = @mid_term_goal.short_term_goals.rank(:row_order)
    # flash[:success] = "短期目標を削除しました"
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
  
    def short_term_goal_params 
      params.require(:short_term_goal).permit(:content, :row_order_position, :status,
        deadline_attributes: :date)
    end 
    
    
    # beforeアクション
    
    # 中期目標をurlのパラメーターからセットする
    def s_set_mid_term_goal
      @mid_term_goal = MidTermGoal.find(params[:mid_term_goal_id])
    end 
    
    # 短期目標をurlのパラメーターからセットする
    def s_set_short_term_goal
      @short_term_goal = ShortTermGoal.find(params[:id])
    end 
    
    # 正しいユーザーかどうか確認
    def s_correct_user
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
