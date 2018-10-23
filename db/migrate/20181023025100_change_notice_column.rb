class ChangeNoticeColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :notices, :link_id, :integer
    add_column :notices, :type, :string
  end
end
