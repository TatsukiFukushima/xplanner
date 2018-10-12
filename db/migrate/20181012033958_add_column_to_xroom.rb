class AddColumnToXroom < ActiveRecord::Migration[5.1]
  def change
    add_column :xrooms, :name, :string
  end
end
