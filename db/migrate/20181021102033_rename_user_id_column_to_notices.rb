class RenameUserIdColumnToNotices < ActiveRecord::Migration[5.1]
  def change
    rename_column :notices, :user_id, :to_id
  end
end
