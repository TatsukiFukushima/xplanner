class AddColumnToLongTermGoal < ActiveRecord::Migration[5.1]
  def change
    add_column :long_term_goals, :status, :integer, default: 0, null: false
  end
end
