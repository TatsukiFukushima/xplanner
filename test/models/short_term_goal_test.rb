require 'test_helper'

class ShortTermGoalTest < ActiveSupport::TestCase
  def setup 
    @user = users(:michael)
    @short_term_goal_1 = short_term_goals(:short_term_goal_1)
  end 
  
  test "should be valid" do 
    assert @short_term_goal_1.valid?
  end 
  
  test "content should be present" do 
    @short_term_goal_1.content = " " 
    assert_not @short_term_goal_1.valid? 
  end 
  
  test "content should not be too long" do 
    @short_term_goal_1.content = "a" * 256 
    assert_not @short_term_goal_1.valid?
  end 
end
