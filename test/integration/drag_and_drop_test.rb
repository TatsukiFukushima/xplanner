require 'test_helper'

class DragAndDropTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:michael)
    @long_term_goal_1 = long_term_goals(:long_term_goal_1)
    @long_term_goal_2 = long_term_goals(:long_term_goal_2)
    @long_term_goal_3 = long_term_goals(:long_term_goal_3)
    @long_term_goal_4 = long_term_goals(:long_term_goal_4)
    log_in_as(@user)
  end 
  
  # test "drag and drop l-term-goals on your own page" do 
  #   get user_long_term_goals_path(user_id: @user.id)
  #   assert_not @user.long_term_goals.empty?
  #   assert_match @user.long_term_goals.count.to_s, response.body
  #   put user_long_term_goal_sort_path(user_id: @user.id, long_term_goal_id: @long_term_goal_1.id),
  #     params: { long_term_goal: { row_order_position: 2 } }
  #   put user_long_term_goal_sort_path(user_id: @user.id, long_term_goal_id: @long_term_goal_2.id),
  #     params: { long_term_goal: { row_order_position: 1 } }
  #   @long_term_goal_1.reload
  #   @long_term_goal_2.reload
  #   get user_long_term_goals_path(user_id: @user.id)
  #   assert_select "table.table-sortable tbody tr:first-child td a[href=?]", edit_user_long_term_goal_path(id: @long_term_goal_2.id)   
  # end
end
