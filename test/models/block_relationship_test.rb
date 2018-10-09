require 'test_helper'

class BlockRelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = BlockRelationship.new(blocked_id: users(:michael).id,
                                     blocker_id: users(:archer).id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a blocker_id" do
    @relationship.blocker_id = nil
    assert_not @relationship.valid?
  end

  test "should require a blocked_id" do
    @relationship.blocked_id = nil
    assert_not @relationship.valid?
  end
end
