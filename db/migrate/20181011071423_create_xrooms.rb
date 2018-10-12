class CreateXrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :xrooms do |t|
      t.references :user, foreign_key: true
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
