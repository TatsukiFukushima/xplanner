class AddLikesCountToMidTermGoal < ActiveRecord::Migration[5.1]
  def change
    add_column :mid_term_goals, :likes_count, :integer, default: 0
  end
end
