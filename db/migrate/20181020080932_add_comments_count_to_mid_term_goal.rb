class AddCommentsCountToMidTermGoal < ActiveRecord::Migration[5.1]
  def change
    add_column :mid_term_goals, :comments_count, :integer, default: 0
  end
end
