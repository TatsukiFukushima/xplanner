require 'test_helper'

class LongTermGoalsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get long_term_goals_new_url
    assert_response :success
  end

  test "should get create" do
    get long_term_goals_create_url
    assert_response :success
  end

  test "should get show" do
    get long_term_goals_show_url
    assert_response :success
  end

  test "should get edit" do
    get long_term_goals_edit_url
    assert_response :success
  end

  test "should get update" do
    get long_term_goals_update_url
    assert_response :success
  end

  test "should get destroy" do
    get long_term_goals_destroy_url
    assert_response :success
  end

end
