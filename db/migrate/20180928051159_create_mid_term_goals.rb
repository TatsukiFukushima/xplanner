class CreateMidTermGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :mid_term_goals do |t|
      t.string :content
      t.integer :row_order
      t.references :long_term_goal, foreign_key: true

      t.timestamps
    end
  end
end
