class LongTermGoalsController < ApplicationController
  def new
  end

  def create
    @user = current_user 
    @long_term_goal = @user.long_term_goals.build(long_term_goals_params)
    if @long_term_goal.save 
      flash[:success] = "長期目標を作成しました"
      redirect_to @user 
    else 
      redirect_to root_path
    end 
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
  
    def long_term_goals_params
      params.require(:long_term_goal).permit(:category, :content)
    end 
end
