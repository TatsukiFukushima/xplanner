require 'test_helper'

class LongTermGoalTest < ActiveSupport::TestCase
  def setup 
    @user = users(:michael)
    @long_term_goal_1 = long_term_goals(:long_term_goal_1)
  end 
  
  test "should be valid" do
    assert @long_term_goal_1.valid?
  end
  
  test "category should be present" do 
    @long_term_goal_1.category = " "
    assert_not @long_term_goal_1.valid?
  end 
  
  test "content should be present" do 
    @long_term_goal_1.content = " "
    assert_not @long_term_goal_1.valid?
  end 
  
  test "category should not be too long" do 
    @long_term_goal_1.category = "a" * 256
    assert_not @long_term_goal_1.valid?
  end 
  
  test "content should not be too long" do 
    @long_term_goal_1.content = "a" * 256 
    assert_not @long_term_goal_1.valid?
  end 
end
