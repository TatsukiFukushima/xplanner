class CreateApproaches < ActiveRecord::Migration[5.1]
  def change
    create_table :approaches do |t|
      t.string :content
      t.integer :effectiveness, default: 0, null: false
      t.integer :row_order
      t.references :short_term_goal, foreign_key: true

      t.timestamps
    end
  end
end
