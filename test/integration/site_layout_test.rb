require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "layout links" do 
    get root_path
    assert_template 'landing_page/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", '#'
    assert_select "a[href=?]", '#'
  end 
end
