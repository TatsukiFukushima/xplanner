class CreateCommentReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :comment_replies do |t|
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
