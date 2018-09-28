require 'test_helper'

class LongTermGoalsControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:michael)
    @other_user = users(:archer)
    @long_term_goal_1 = long_term_goals(:long_term_goal_1)
  end 
  
  test "should get new" do
    log_in_as(@user)
    get new_user_long_term_goal_path(@user)
    assert_response :success
  end

  test "should redirect new when not logged in" do 
    get new_user_long_term_goal_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end 
  
  test "should redirect create when not logged in" do 
    post user_long_term_goals_path(@user),
      params: { long_term_goal: { category: "Programming", content: "aiueoaiueo" } }
    assert_not flash.empty?
    assert_redirected_to login_url 
  end 
  
  test "should redirect index when not logged in" do 
    get user_long_term_goals_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url 
  end 
  
  test "should redirect edit when not logged in" do 
    get edit_long_term_goal_path(@long_term_goal_1)
    assert_not flash.empty?
    assert_redirected_to login_url 
  end 
  
  test "should redirect update when not logged in" do 
    patch long_term_goal_path(@long_term_goal_1),
      params: { long_term_goal: { category: "programming", content: "bbbbbbbbbbbbbbbbbb" } }
    assert_not flash.empty?
    assert_redirected_to login_url 
  end 
  
  test "should redirect destroy when not logged in" do 
    delete long_term_goal_path(@long_term_goal_1)
    assert_not flash.empty?
    assert_redirected_to login_url 
  end
  
  test "should redirect new when logged in as wrong user" do 
    log_in_as(@other_user)
    get new_user_long_term_goal_path(user_id: @long_term_goal_1.user_id, id: @long_term_goal_1.id)
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect create when logged in as wrong user" do 
    log_in_as(@other_user)
    post user_long_term_goals_path(@user),
      params: { long_term_goal: { category: "Programming", content: "aiueoaiueo" } }
    assert flash.empty?
    assert_redirected_to root_url
  end  
  
  test "should redirect edit when logged in as wrong user" do 
    log_in_as(@other_user)
    get edit_long_term_goal_path(@long_term_goal_1)
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong user" do 
    log_in_as(@other_user)
    patch long_term_goal_path(@long_term_goal_1),
      params: { long_term_goal: { category: "programming", content: "bbbbbbbbbbbbbbbbbb" } }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect destroy when logged in as wrong user" do 
    log_in_as(@other_user)
    delete long_term_goal_path(@long_term_goal_1)
    assert flash.empty?
    assert_redirected_to root_url
  end  
end
