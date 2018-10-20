class AddLikesCountToShortTermGoal < ActiveRecord::Migration[5.1]
  def change
    add_column :short_term_goals, :likes_count, :integer, default: 0
  end
end
