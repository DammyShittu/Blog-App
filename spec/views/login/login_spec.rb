require 'rails_helper'

RSpec.feature "Sessions Page" do
  feature "shows the right fields" do
    background { visit new_user_session_path }

    scenario "displays email field" do
      expect(page).to have_field('user[email]')
    end

    scenario "displays password field" do
      expect(page).to have_field('user[password]')
    end

    scenario "displays email field" do
      expect(page).to have_button('Log in')
    end
  end

  # feature "check wrong submissions" do
    scenario 'submit form without email and password' do
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end

    scenario 'submit form with incorrect email and password' do
      fill_in 'Email', with: 'jkfirst@yahoo.com'
      fill_in 'Password', with: '222222'
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end
  end

  feature "redirect to right path after authentication" do
    scenario "Path should change on sucessful login" do
      @user = User.create(name: "Adedamola Shittu", bio: "Software Developer", email: "johndoe24@gmail.com", password: "password", confirmed_at: Time.now)
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'

    expect(page).to have_current_path(authenticated_root_path)
  end
  end
end
