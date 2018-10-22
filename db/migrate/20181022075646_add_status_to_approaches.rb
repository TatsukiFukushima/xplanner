class AddStatusToApproaches < ActiveRecord::Migration[5.1]
  def change
    add_column :approaches, :status, :integer, default: 0, null: false
  end
end
