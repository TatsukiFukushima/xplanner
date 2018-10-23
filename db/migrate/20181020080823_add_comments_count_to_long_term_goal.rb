class AddCommentsCountToLongTermGoal < ActiveRecord::Migration[5.1]
  def change
    add_column :long_term_goals, :comments_count, :integer, default: 0
  end
end
