require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'User #Show', type: :feature do
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
    expect(find('img') do |img|
             img[:src] == 'http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg'
           end).to be_truthy
  end

  scenario "show user's name" do
    find("a[href='#{user_path(@user3.id)}']").click
    expect(page).to have_content 'Julie Ify'
  end

  scenario 'show number of posts per user' do
    Post.create(title: 'How To unit test with Rspec', text: 'Try to check on Google.', author_id: @user1.id)
    Post.create(title: 'Avoiding procrastination', text: 'lorem ipsummffjglgirrin snsnsjdidor', author_id: @user1.id)

    find("a[href='#{user_path(@user1.id)}']").click
    expect(page).to have_content 'Number of posts: 2'
  end

  scenario "show user's bio." do
    Post.create(title: 'Oversabi dey kill', text: 'lorem ipsummffjglgirrin snsnsjdidor', author_id: @user2.id)

    find("a[href='#{user_path(@user2.id)}']").click
    expect(page).to have_content 'Software Developer'
  end

  scenario "show user's first 3 posts." do
    Post.create(title: 'Let Us Win', text: 'Etiam et mauris et', author_id: @user1.id)
    Post.create(title: 'Rails Routes', text: 'et mauris et ligula', author_id: @user1.id)
    Post.create(title: 'Why I love Programming', text: 'Etiam et et ligula', author_id: @user1.id)
    Post.create(title: 'Love World', text: 'iam et et ligula', author_id: @user1.id)
    find("a[href='#{user_path(@user1.id)}']").click
    expect(page).to_not have_content 'Let Us Win'
  end

  scenario "show button that lets me view all of a user's posts." do
    find("a[href='#{user_path(@user3.id)}']").click
    expect(page).to have_link('See all posts')
  end

  scenario "click post and redirect to that post's show page." do
    @post = Post.create(title: 'Lorem ipsum dolor', text: 'Etiam et mauris et', author_id: @user2.id)
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_current_path(user_post_path(@user2.id, @post.id))
  end

  scenario "click see all posts and redirects to user's post's index page." do
    @post = Post.create(title: 'Lorem ipsum dolor', text: 'Etiam et mauris et', author_id: @user2.id)
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page).to have_current_path(user_posts_path(@user2.id))
  end
  # rubocop:enable Metrics/BlockLength
end
