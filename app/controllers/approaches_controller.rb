class ApproachesController < ApplicationController
  before_action :a_set_approach, only: [:edit, :update, :destroy]
  before_action :a_set_short_term_goal, only: [:new, :create, :index]
  before_action :logged_in_user 
  before_action :a_correct_user, except: [:sort, :index]
  
  
  def new
    @approach = @short_term_goal.approaches.build
    @approach.build_deadline
  end
  
  def create
    @approach = @short_term_goal.approaches.build(approach_params)
    @mid_term_goal = @short_term_goal.mid_term_goal 
    if @approach.save 
      @approaches = @short_term_goal.approaches.rank(:row_order) 
      # flash[:success] = "アプローチを作成しました"
    else 
      render 'new'
    end 
  end 
  
  def index 
    @user = @short_term_goal.mid_term_goal.long_term_goal.user
    @approaches = @short_term_goal.approaches.rank(:row_order) 
  end 

  def edit
  end
  
  def update 
    @short_term_goal = @approach.short_term_goal 
    @mid_term_goal = @short_term_goal.mid_term_goal 
    if @approach.update_attributes(approach_params)
      @approaches = @short_term_goal.approaches.rank(:row_order) 
      if params[:date] || (request.referer == root_url)
        @l_goals =                       @user.long_term_goals
        @l_goals_by_date =               @l_goals.group_by { |l_goal| l_goal.deadline.date }
        @m_goals =                       @user.mid_term_goals
        @m_goals_by_date =               @m_goals.group_by { |m_goal| m_goal.deadline.date }
        @s_goals =                       @user.short_term_goals
        @s_goals_by_date =               @s_goals.group_by { |s_goal| s_goal.deadline.date }
        @approaches =                    @user.approaches
        @approaches_by_date =            @approaches.group_by { |approach| approach.deadline.date }
        @date =                          params[:date] ? Date.parse(params[:date]) : Date.today
      end 
    else 
      render 'new'
    end 
  end 
  
  def destroy 
    @short_term_goal = @approach.short_term_goal
    @mid_term_goal = @short_term_goal.mid_term_goal 
    @approach.destroy 
    @approaches = @short_term_goal.approaches.rank(:row_order) 
    # flash[:success] = "アプローチを削除しました"
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
    
    def approach_params 
      params.require(:approach).permit(:user_id, :content, :row_order_position, :status, :effectiveness,
        deadline_attributes: :date)
    end 
    
    # beforeアクション
    
    # 短期目標をurlのパラメーターからセットする
    def a_set_short_term_goal
      @short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
    end 
    
    # アプローチをurlのパラメーターからセットする
    def a_set_approach
      @approach = Approach.find(params[:id])
    end 
    
    # 正しいユーザーかどうか確認
    def a_correct_user
      if params[:short_term_goal_id]
        @short_term_goal = ShortTermGoal.find(params[:short_term_goal_id])
        @user = @short_term_goal.mid_term_goal.long_term_goal.user 
      else 
        @user = @approach.short_term_goal.mid_term_goal.long_term_goal.user 
      end 
      redirect_to(root_url) unless current_user?(@user)
    end 
end
