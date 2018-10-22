class AddUserToShortTermGoals < ActiveRecord::Migration[5.1]
  def change
    add_reference :short_term_goals, :user, foreign_key: true
  end
end
