class FixColumnNames < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :postsCounter, :posts_counter
    rename_column :comments, :user_id, :author_id
    rename_column :likes, :user_id, :author_id

    change_table :posts do |t|
      t.rename :likesCounter, :likes_counter
      t.rename :commentsCounter, :comments_counter
      t.rename :user_id, :author_id
    end
  end
end
