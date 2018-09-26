class LongTermGoalsController < ApplicationController
  before_action :set_long_term_goal, only: [:show, :edit, :update, :destroy]
  
  def sort 
    long_term_goal = LongTermGoal.find(params[:long_term_goal_id])
    long_term_goal.update(long_term_goal_params)
    render nothing: true
  end 
  
  def new
    @user = User.find(params[:user_id])
    @long_term_goal = @user.long_term_goals.build
  end

  def create
    @user = current_user 
    @long_term_goal = @user.long_term_goals.build(long_term_goal_params)
    if @long_term_goal.save 
      flash[:success] = "長期目標を作成しました"
      redirect_to user_long_term_goals_path
    else 
      redirect_to root_path
    end 
  end
  
  def index 
    @user = User.find(params[:user_id])
    @long_term_goals = @user.long_term_goals.rank(:row_order)
  end 

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  
  private 
  
  def set_long_term_goal
    @long_term_goal = LongTermGoal.find(params[:id])
  end 
  
    def long_term_goal_params
      params.require(:long_term_goal).permit(:category, :content, :row_order_position)
    end 
end
