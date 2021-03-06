class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :comments_counter, null: false, default: 0
      t.integer :likes_counter, null: false, default: 0

      t.timestamps
    end
  end
end
