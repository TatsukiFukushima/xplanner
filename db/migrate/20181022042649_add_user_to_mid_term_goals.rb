class AddUserToMidTermGoals < ActiveRecord::Migration[5.1]
  def change
    add_reference :mid_term_goals, :user, foreign_key: true
  end
end
