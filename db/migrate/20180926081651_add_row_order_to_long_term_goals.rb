class AddRowOrderToLongTermGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :long_term_goals, :row_order, :integer
  end
end
