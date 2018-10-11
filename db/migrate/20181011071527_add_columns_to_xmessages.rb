class AddColumnsToXmessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :xmessages, :user, foreign_key: true
    add_reference :xmessages, :xroom, foreign_key: true
  end
end
