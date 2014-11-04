require 'rails_helper'

context "user not signed in and on the homepage" do
  it "should see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).to have_link('Sign in')
    expect(page).to have_link('Sign up')
  end

  it "should not see 'sign out' link" do
    visit('/')
    expect(page).not_to have_link('Sign out')
  end

end

context "user signed in on the homepage" do

  before do
    test_user = User.create(email: "sean@makers.com", password: "12345678", password_confirmation: "12345678")
    login_as test_user
    # visit('/')
    # click_link('Sign up')
    # fill_in('Email', with: 'test@example.com')
    # fill_in('Password', with: 'testtest')
    # fill_in('Password confirmation', with: 'testtest')
    # click_button('Sign up')
  end

  it "should see 'sign out' link" do
    visit('/')
    expect(page).to have_link('Sign out')
  end

  it "should not see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
  end

  it "should be able to edit a restaurant theyve added" do
    Restaurant.create(name: 'Thai')
    visit('/')
    expect(page).to have_content('Thai')
    click_link('Edit Thai')
    expect(page).to have_content("You're not allowed to edit!")
  end

end

context "user not signed in" do

  it "should see login form when trying to click add a restaurant " do
    visit('/')
    click_link('Add a restaurant')
    expect(page).to have_content('Log in')
  end

end

