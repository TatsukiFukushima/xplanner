require 'test_helper'

class ApproachTest < ActiveSupport::TestCase
  def setup 
    @user = users(:michael)
    @approach_1 = approaches(:approach_1)
  end 
  
  test "should be valid" do 
    assert @approach_1.valid?
  end 
  
  test "content should be present" do 
    @approach_1.content = " " 
    assert_not @approach_1.valid?
  end 
  
  test "content should not be too long" do 
    @approach_1.content = "a" * 256
    assert_not @approach_1.valid?
  end 
end
