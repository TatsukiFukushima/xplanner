class ChangeNoticeColumn2 < ActiveRecord::Migration[5.1]
  def change
    rename_column :notices, :type, :link_to
    remove_column :notices, :link_id
  end
end
