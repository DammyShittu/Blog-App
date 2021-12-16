class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: :comments_counter

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
