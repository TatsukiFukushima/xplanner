class RenameUserIdColumnToNotices < ActiveRecord::Migration[5.1]
  def change
    add_column :notices, :type, :string
    add_column :notices, :link_id, :integer
  end
end
