class LandingPageController < ApplicationController
  
  def home
    @user = current_user if logged_in?
    if @user 
      @l_goals =                       @user.long_term_goals
      @l_goals_by_date =               @l_goals.group_by { |l_goal| l_goal.deadline.date }
      @m_goals =                       @user.mid_term_goals
      @m_goals_by_date =               @m_goals.group_by { |m_goal| m_goal.deadline.date }
      @s_goals =                       @user.short_term_goals
      @s_goals_by_date =               @s_goals.group_by { |s_goal| s_goal.deadline.date }
      @approaches =                    @user.approaches
      @approaches_by_date =            @approaches.group_by { |approach| approach.deadline.date }
      @date =                          params[:date] ? Date.parse(params[:date]) : Date.today
      @your_updated_l_goals =          @user.your_updated_l_goals                                 if params[:your_updated_l_goals].present?
      @your_updated_m_goals =          @user.your_updated_m_goals                                 if params[:your_updated_m_goals].present?
      @your_updated_s_goals =          @user.your_updated_s_goals                                 if params[:your_updated_s_goals].present?
      @your_updated_approaches =       @user.your_updated_approaches                              if params[:your_updated_approaches].present?
      @your_xrooms =                   @user.your_xrooms                                          if params[:your_xrooms].present?
      @your_ongoing_l_goals =          @user.your_ongoing_l_goals                                 if params[:your_ongoing_l_goals].present?
      @your_ongoing_m_goals =          @user.your_ongoing_m_goals                                 if params[:your_ongoing_m_goals].present?
      @your_ongoing_s_goals =          @user.your_ongoing_s_goals                                 if params[:your_ongoing_s_goals].present?
      @your_ongoing_approaches =       @user.your_ongoing_approaches                              if params[:your_ongoing_approaches].present?
      @your_achieved_l_goals =         @user.your_achieved_l_goals                                if params[:your_achieved_l_goals].present?
      @your_achieved_m_goals =         @user.your_achieved_m_goals                                if params[:your_achieved_m_goals].present?
      @your_achieved_s_goals =         @user.your_achieved_s_goals                                if params[:your_achieved_s_goals].present?
      @your_achieved_approaches =      @user.your_achieved_approaches                             if params[:your_achieved_approaches].present?
      @your_favorite_l_goals =         LongTermGoal.your_favorite_l_goals(current_user.id)        if params[:your_favorite_l_goals].present?
      @your_favorite_m_goals =         MidTermGoal.your_favorite_m_goals(current_user.id)         if params[:your_favorite_m_goals].present?
      @your_favorite_s_goals =         ShortTermGoal.your_favorite_s_goals(current_user.id)       if params[:your_favorite_s_goals].present?
      @your_favorite_approaches =      Approach.your_favorite_approaches(current_user.id)         if params[:your_favorite_approaches].present?
      @your_resent_followings =        User.your_resent_followings(current_user.id)               if params[:your_resent_followings].present?
      @followers_updated_l_goals =     LongTermGoal.followers_updated_l_goals(current_user.id)    if params[:followers_updated_l_goals].present?
      @followers_updated_m_goals =     MidTermGoal.followers_updated_m_goals(current_user.id)     if params[:followers_updated_m_goals].present?
      @followers_updated_s_goals =     ShortTermGoal.followers_updated_s_goals(current_user.id)   if params[:followers_updated_s_goals].present?
      @followers_updated_approaches =  Approach.followers_updated_approaches(current_user.id)     if params[:followers_updated_approaches].present?
      @followers_resent_xrooms =       Xroom.followers_resent_xrooms(current_user.id)             if params[:followers_resent_xrooms].present?
      @followers_ongoing_l_goals =     LongTermGoal.followers_ongoing_l_goals(current_user.id)    if params[:followers_ongoing_l_goals].present?
      @followers_ongoing_m_goals =     MidTermGoal.followers_ongoing_m_goals(current_user.id)     if params[:followers_ongoing_m_goals].present?
      @followers_ongoing_s_goals =     ShortTermGoal.followers_ongoing_s_goals(current_user.id)   if params[:followers_ongoing_s_goals].present?
      @followers_ongoing_approaches =  Approach.followers_ongoing_approaches(current_user.id)     if params[:followers_ongoing_approaches].present?
      @followers_achieved_l_goals =    LongTermGoal.followers_achieved_l_goals(current_user.id)   if params[:followers_achieved_l_goals].present?
      @followers_achieved_m_goals =    MidTermGoal.followers_achieved_m_goals(current_user.id)    if params[:followers_achieved_m_goals].present?
      @followers_achieved_s_goals =    ShortTermGoal.followers_achieved_s_goals(current_user.id)  if params[:followers_achieved_s_goals].present?
      @followers_achieved_approaches = Approach.followers_achieved_approaches(current_user.id)    if params[:followers_achieved_approaches].present?
      @followers_favorite_l_goals =    LongTermGoal.followers_favorite_l_goals(current_user.id)   if params[:followers_favorite_l_goals].present?
      @followers_favorite_m_goals =    MidTermGoal.followers_favorite_m_goals(current_user.id)    if params[:followers_favorite_m_goals].present?
      @followers_favorite_s_goals =    ShortTermGoal.followers_favorite_s_goals(current_user.id)  if params[:followers_favorite_s_goals].present?
      @followers_favorite_approaches = Approach.followers_favorite_approaches(current_user.id)    if params[:followers_favorite_approaches].present?
      @followers_resent_followings =   User.followers_resent_followings(current_user.id)          if params[:followers_resent_followings].present?
      @l_rank =                        LongTermGoal.l_rank                                        if params[:l_rank].present?
      @m_rank =                        MidTermGoal.m_rank                                         if params[:m_rank].present?
      @s_rank =                        ShortTermGoal.s_rank                                       if params[:s_rank].present?
      @a_rank =                        Approach.a_rank                                            if params[:a_rank].present?
      @u_rank =                        User.u_rank                                                if params[:u_rank].present?
    end 
  end 
end


