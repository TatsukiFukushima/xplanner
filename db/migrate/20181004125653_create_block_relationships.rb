class CreateBlockRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :block_relationships do |t|
      t.integer :blocker_id
      t.integer :blocked_id
      
      t.timestamps
    end
    add_index :block_relationships, :blocker_id
    add_index :block_relationships, :blocked_id
    add_index :block_relationships, [:blocker_id, :blocked_id], unique: true
  end
end
