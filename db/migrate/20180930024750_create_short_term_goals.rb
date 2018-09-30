class CreateShortTermGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :short_term_goals do |t|
      t.string :content
      t.integer :status, default: 0, null: false
      t.integer :row_order
      t.references :mid_term_goal, foreign_key: true

      t.timestamps
    end
  end
end
