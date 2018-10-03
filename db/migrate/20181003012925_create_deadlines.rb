class CreateDeadlines < ActiveRecord::Migration[5.1]
  def change
    create_table :deadlines do |t|
      t.references :due_date, polymorphic: true
      t.date :date

      t.timestamps
    end
  end
end
