class SearchController < ApplicationController
  
  def result 
    @users = User.search(search: params[:search], order: params[:user_follower_p]).paginate(page: params[:page], per_page: 10) if params[:user_p] || params[:nav_u_p]
    @l_goals = LongTermGoal.search(search: params[:search], category_kwd: params[:l_category], status: params[:status], like_order: params[:like_count_p], comment_order: params[:comment_count_p]).paginate(page: params[:page], per_page: 10) if params[:l_goal_p] || params[:nav_l_p]
    @m_goals = MidTermGoal.search(search: params[:search], status: params[:status], like_order: params[:like_count_p], comment_order: params[:comment_count_p]).paginate(page: params[:page], per_page: 10) if params[:m_goal_p] || params[:nav_m_p]
    @s_goals = ShortTermGoal.search(search: params[:search], status: params[:status], like_order: params[:like_count_p], comment_order: params[:comment_count_p]).paginate(page: params[:page], per_page: 10) if params[:s_goal_p] || params[:nav_s_p]
    @approaches = Approach.search(search: params[:search], effectiveness: params[:effectiveness], status: params[:status], like_order: params[:like_count_p], comment_order: params[:comment_count_p]).paginate(page: params[:page], per_page: 10) if params[:approach_p] || params[:nav_a_p]
  end 
end
