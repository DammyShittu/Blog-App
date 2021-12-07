class Like < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User'

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
