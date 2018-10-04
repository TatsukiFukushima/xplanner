class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :likable, polymorphic: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:likable_type, :likable_id, :user_id], unique: true
  end
end
