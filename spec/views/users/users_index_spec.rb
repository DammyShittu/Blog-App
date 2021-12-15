require 'rails_helper'

RSpec.feature "Users Page" do
  feature "shows users" do
    background do 
      visit users_path 
      @user = User.create(name: "Adedamola Shittu", bio: "Software Developer", email: "johndoe24@gmail.com", password: "password", confirmed_at: Time.now)
    end

    scenario "Shows the username" do
      expect(page).to have_content('Adedamola Shittu')
    end

    scenario "Shows the user's photo" do
      expect(page).to have_content('no_image.png')
    end

    scenario "Shows the number of posts" do
      expect(page).to have_content('Number of posts: 0')
    end

    scenario "Shows the number of posts" do
      expect(page).to have_content('Number of posts: 0')
    end

    scenario "after clicking on the user, it will be redirected to that user's show page" do
      click_link "#{@user.id}"
      expect(page).to have_current_path(user_path(@user.id))
    end
end