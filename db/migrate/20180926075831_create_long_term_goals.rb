class CreateLongTermGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :long_term_goals do |t|
      t.string :category
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
