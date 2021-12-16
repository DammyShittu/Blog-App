require 'rails_helper'
# rubocop:disable Metrics/BlockLength

RSpec.feature 'Post #Index', type: :feature do
  background do
    visit new_user_session_path

    @user1 = User.create(name: 'Adedamola Shittu', bio: 'Software Developer',
                         photo: 'http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg',
                         email: 'johndoe24@gmail.com', password: 'password', confirmed_at: Time.now)
    @user2 = User.create(name: 'Henry Eze', bio: 'Software Developer',
                         photo: 'http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg',
                         email: 'kchenry@gmail.com', password: 'passion', confirmed_at: Time.now)
    @user3 = User.create(name: 'Julie Ify', bio: 'Software Developer',
                         photo: 'http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg',
                         email: 'ifyjuls@gmail.com', password: 'willpower', confirmed_at: Time.now)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
  end

  scenario "show user's profile picture" do
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(find('img') do |img|
             img[:src] == 'http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg'
           end).to be_truthy
  end

  scenario "show user's name" do
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page).to have_content 'Henry Eze'
  end

  scenario 'show number of posts per user' do
    Post.create(title: 'How To unit test with Rspec', text: 'Try to check on Google.', author_id: @user1.id)
    Post.create(title: 'Avoiding procrastination', text: 'lorem ipsummffjglgirrin snsnsjdidor', author_id: @user1.id)

    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    expect(page).to have_content "Number of posts: #{@user1.posts.size}"
  end

  scenario 'show post title.' do
    Post.create(title: 'How To unit test with Rspec', text: 'Try to check on Google.', author_id: @user3.id)
    find("a[href='#{user_path(@user3.id)}']").click
    find("a[href='#{user_posts_path(@user3.id)}']").click
    expect(page).to have_content 'How To unit test with Rspec'
  end

  scenario " show some of the post's body." do
    Post.create(title: 'How To unit test with Rspec',
                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque
                justo ligula, elementum ac mattis et, vulputate ac nibh. Phasellus fringilla
                blandit molestie. Donec tincidunt commodo magna. Proin iaculis cursus', author_id: @user3.id)
    find("a[href='#{user_path(@user3.id)}']").click
    find("a[href='#{user_posts_path(@user3.id)}']").click
    expect(page).to have_content 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque justo ligula,'
  end

  scenario 'show the first comments on a post.' do
    @post = Post.create(title: 'Let\s have fun', text: 'Donec tincidunt commodo magna. Proin iaculis cursus',
                        author_id: @user1.id)
    @comment = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user1.id,
                              post_id: @post.id)

    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    expect(page).to have_content 'Donec tincidunt commodo magna. Proin iaculis cursus'
  end

  scenario 'show how many comments a post has.' do
    @post = Post.create(title: 'Lorem Ipsum', text: 'Donec tincidunt commodo magna. Proin iaculis cursus',
                        author_id: @user2.id)
    @comment1 = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                               post_id: @post.id)
    @comment2 = Comment.create(text: 'consectetur adipiscing e mollislibero non urna', author_id: @user2.id,
                               post_id: @post.id)

    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page).to have_content 'Comments : 2'
  end

  scenario 'show how many likes a post has.' do
    @post = Post.create(title: 'Lorem Ipsum', text: 'Donec tincidunt commodo magna. Proin iaculis cursus',
                        author_id: @user3.id)
    Like.create(author_id: @user3.id, post_id: @post.id)
    Like.create(author_id: @user2.id, post_id: @post.id)
    Like.create(author_id: @user1.id, post_id: @post.id)

    find("a[href='#{user_path(@user3.id)}']").click
    find("a[href='#{user_posts_path(@user3.id)}']").click
    expect(page).to have_content 'Likes : 3'
  end

  scenario 'show pagination button' do
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    expect(page.has_button?('Pagination')).to be true
  end

  scenario "click on post and redirect to that post's show page." do
    @post = Post.create(title: 'hello there', text: 'Etiam et mauris et', author_id: @user1.id)
    find("a[href='#{user_path(@user1.id)}']").click
    find("a[href='#{user_posts_path(@user1.id)}']").click
    find("a[href='#{user_post_path(@user1.id, @post.id)}']").click
    expect(page).to have_current_path(user_post_path(@user1.id, @post.id))
  end
  # rubocop:enable Metrics/BlockLength
end
