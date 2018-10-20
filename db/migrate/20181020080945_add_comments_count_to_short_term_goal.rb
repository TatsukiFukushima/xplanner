class AddCommentsCountToShortTermGoal < ActiveRecord::Migration[5.1]
  def change
    add_column :short_term_goals, :comments_count, :integer, default: 0
  end
end
