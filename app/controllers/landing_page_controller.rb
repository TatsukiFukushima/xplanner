class LandingPageController < ApplicationController
  
  def home
    @user = current_user if logged_in?
    if @user 
      @your_updated_l_goals = @user.your_updated_l_goals 
      @your_updated_m_goals = @user.your_updated_m_goals
      @your_updated_s_goals = @user.your_updated_s_goals
      @your_updated_approaches = @user.your_updated_approaches
      @your_xrooms = @user.your_xrooms
      @your_ongoing_l_goals = @user.your_ongoing_l_goals 
      @your_ongoing_m_goals = @user.your_ongoing_m_goals 
      @your_ongoing_s_goals = @user.your_ongoing_s_goals 
      @your_ongoing_approaches = @user.your_ongoing_approaches
      @your_achieved_l_goals = @user.your_achieved_l_goals 
      @your_achieved_m_goals = @user.your_achieved_m_goals 
      @your_achieved_s_goals = @user.your_achieved_s_goals 
      @your_achieved_approaches = @user.your_achieved_approaches 
      @your_favorite_l_goals = LongTermGoal.your_favorite_l_goals(current_user.id) 
      @your_favorite_m_goals = MidTermGoal.your_favorite_m_goals(current_user.id)
      @your_favorite_s_goals = ShortTermGoal.your_favorite_s_goals(current_user.id)
      @your_favorite_approaches = Approach.your_favorite_approaches(current_user.id)
      @your_resent_followings = User.your_resent_followings(current_user.id)
      @followers_updated_l_goals = LongTermGoal.followers_updated_l_goals(current_user.id)
      @followers_updated_m_goals = MidTermGoal.followers_updated_m_goals(current_user.id)
      @followers_updated_s_goals = ShortTermGoal.followers_updated_s_goals(current_user.id)
      @followers_updated_approaches = Approach.followers_updated_approaches(current_user.id)
      @followers_resent_xrooms = Xroom.followers_resent_xrooms(current_user.id)
      @followers_ongoing_l_goals = LongTermGoal.followers_ongoing_l_goals(current_user.id)
      @followers_ongoing_m_goals = MidTermGoal.followers_ongoing_m_goals(current_user.id)
      @followers_ongoing_s_goals = ShortTermGoal.followers_ongoing_s_goals(current_user.id)
      @followers_ongoing_approaches = Approach.followers_ongoing_approaches(current_user.id)
      @followers_achieved_l_goals = LongTermGoal.followers_achieved_l_goals(current_user.id)
      @followers_achieved_m_goals = MidTermGoal.followers_achieved_m_goals(current_user.id)
      @followers_achieved_s_goals = ShortTermGoal.followers_achieved_s_goals(current_user.id)
      @followers_achieved_approaches = Approach.followers_achieved_approaches(current_user.id)
      @followers_favorite_l_goals = LongTermGoal.followers_favorite_l_goals(current_user.id)
      @followers_favorite_m_goals = MidTermGoal.followers_favorite_m_goals(current_user.id)
      @followers_favorite_s_goals = ShortTermGoal.followers_favorite_s_goals(current_user.id)
      @followers_favorite_approaches = Approach.followers_favorite_approaches(current_user.id)
      @followers_resent_followings = User.followers_resent_followings(current_user.id)
      @l_rank = LongTermGoal.l_rank
      @m_rank = MidTermGoal.m_rank
      @s_rank = ShortTermGoal.s_rank
      @a_rank = Approach.a_rank
      @u_rank = User.u_rank
    end 
  end 
end


