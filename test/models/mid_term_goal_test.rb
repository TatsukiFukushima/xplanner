require 'test_helper'

class MidTermGoalTest < ActiveSupport::TestCase
  def setup 
    @user = users(:michael)
    @mid_term_goal_1 = mid_term_goals(:mid_term_goal_1)
  end 
  
  test "should be valid" do 
    assert @mid_term_goal_1.valid?
  end 
  
  test "content should be present" do 
    @mid_term_goal_1.content = " " 
    assert_not @mid_term_goal_1.valid?
  end 
  
  test "content should not be too long" do 
    @mid_term_goal_1.content = "a" * 256 
    assert_not @mid_term_goal_1.valid?
  end 
end
