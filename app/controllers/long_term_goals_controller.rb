class LongTermGoalsController < ApplicationController
  before_action :l_set_long_term_goal, only: [:show, :edit, :update, :destroy]
  before_action :l_set_user, only: [:new, :create, :index]
  before_action :logged_in_user 
  before_action :l_correct_user, except: [:sort, :index]
  before_action :is_blocked?, only: [:index]

  
  
  def new
    @long_term_goal = @user.long_term_goals.build
    @long_term_goal.build_deadline
  end

  def create
    @long_term_goal = @user.long_term_goals.build(long_term_goal_params)
    if @long_term_goal.save 
      # flash[:success] = "長期目標を作成しました"
      @long_term_goals = @user.long_term_goals.rank(:row_order)
    else 
      render 'new'
    end 
  end
  
  def index 
    @long_term_goals = @user.long_term_goals.rank(:row_order)
  end 

  def edit
  end

  def update
    if @long_term_goal.update_attributes(long_term_goal_params)
      @long_term_goals = @user.long_term_goals.rank(:row_order)
    else
      render 'edit'
    end 
  end

  def destroy
    @long_term_goal.destroy
    # flash[:success] = "長期目標を削除しました"
    @long_term_goals = @user.long_term_goals.rank(:row_order)
  end
  
  # 並び替えのデータ（row_order_position）を更新するメソッド
  #（正しいユーザーがドラッグアンドドロップした時のみ更新する）
  def sort 
    long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
    @user = long_term_goal.user
    if @user == current_user
      long_term_goal.update(long_term_goal_params)
      render body: nil
    end
  end 
  
  
  private 
  
    def long_term_goal_params
      params.require(:long_term_goal).permit(:category, :content, :row_order_position, :status,
        deadline_attributes: :date)
    end 
    
    
    # beforeアクション
    
    # ある長期目標一覧のユーザーををurlのパラメーターからセットする
    def l_set_user
      @user = User.find(params[:user_id])
    end 
    
    # 長期目標をurlのパラメーターからセットする
    def l_set_long_term_goal
      @long_term_goal = LongTermGoal.find(params[:id])
    end 

    # 正しいユーザーかどうか確認
    def l_correct_user
      if params[:user_id]
        @user = User.find(params[:user_id])
      else 
        @user = @long_term_goal.user
      end
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # ブロックされているか確認
    def is_blocked?
      user = User.find_by(id: params[:user_id])
      if user.blocking?(current_user)
        render '/users/blocked'
      end
    end
end
