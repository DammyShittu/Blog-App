require 'rails_helper'

RSpec.feature 'Posts #Show', type: :feature do
  background do
    visit new_user_session_path

    @user1 = User.create(name: 'Adedamola Shittu', bio: 'Software Developer',
                         photo: 'http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg',
                         email: 'johndoe24@gmail.com', password: 'password', confirmed_at: Time.now
                        )
    @user2 = User.create(name: 'Amine Smahi', bio: 'Software Developer',
                         photo: 'http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg',
                         email: 'amine@gmail.com', password: 'willpower', confirmed_at: Time.now
                        )

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
  end

  scenario 'show post title.' do
    @post = Post.create(title: 'How To unit test with Rspec', text: 'Try to check on Google.', author_id: @user1.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_content 'How To unit test with Rspec'
  end

  scenario 'show post author' do
    @post = Post.create(title: 'How To unit test with Rspec', text: 'Try to check on Google.', author_id: @user1.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_content @user1.name
  end

  scenario 'show how many comments a post has.' do
    @post = Post.create(title: 'How To unit test with Rspec', text: 'Try to check on Google.', author_id: @user1.id)
    @comment1 = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user1.id,
                               post_id: @post.id)
    @comment2 = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user1.id,
                               post_id: @post.id)
    @comment2 = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user1.id,
                               post_id: @post.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_content 'Comments : 3'
  end

  scenario 'show how many likes a post has.' do
    @post = Post.create(title: 'How To unit test with Rspec', text: 'Try to check on Google.', author_id: @user2.id)
    Like.create(author_id: @user2.id, post_id: @post.id)
    Like.create(author_id: @user1.id, post_id: @post.id)
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content 'Likes : 2'
  end

  scenario 'show body of the post' do
    @post = Post.create(title: 'How To unit test with Rspec',
                        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                        Pellentesque justo ligula, elementum ac mattis et, vulputate ac nibh.
                        Phasellus fringilla blandit molestie. Donec tincidunt commodo magna.
                        Proin iaculis cursus', author_id: @user2.id
                      )
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content @post.text
  end

  scenario 'show names of users that made comments' do
    @post = Post.create(title: 'How To unit test with Rspec', text: 'Try to check on Google.', author_id: @user1.id)
    @comment1 = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user1.id,
                               post_id: @post.id)
    @comment2 = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                               post_id: @post.id)
    @comment3 = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                               post_id: @post.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_content @user1.name
    expect(page).to have_content @user2.name
  end

  scenario 'show comments that have been made' do
    @post = Post.create(title: 'How To unit test with Rspec', text: 'Try to check on Google.', author_id: @user1.id)
    @comment1 = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user1.id,
                               post_id: @post.id)
    @comment2 = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                               post_id: @post.id)
    @comment3 = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                               post_id: @post.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_content @comment1.text
    expect(page).to have_content @comment2.text
    expect(page).to have_content @comment3.text
  end
end
