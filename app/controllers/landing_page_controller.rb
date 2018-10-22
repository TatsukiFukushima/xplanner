class LandingPageController < ApplicationController
  
  def home
    @user = current_user if logged_in?
    @l_rank = LongTermGoal.l_rank
    @m_rank = MidTermGoal.m_rank
    @s_rank = ShortTermGoal.s_rank
    @a_rank = Approach.a_rank
    @u_rank = User.u_rank
    @your_updated_l_goals = @user.your_updated_l_goals 
    @your_updated_m_goals = @user.your_updated_m_goals
  end 
end


