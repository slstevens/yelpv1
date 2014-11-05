require 'rails_helper'

describe 'reviewing' do
  before do
    Restaurant.create(name: 'KFC')
  end

  it 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave review'
  end

  it 'displays an average rating for all reviews' do
    test_user = User.create(email: "sean@makers.com", password: "12345678", password_confirmation: "12345678")
    login_as test_user
    leave_review('So so', "3")
    click_link 'Sign out'
    test_user2 = User.create(email: "sean2@makers.com", password: "12345678", password_confirmation: "12345678")
    login_as test_user2
    leave_review('Great', "5")
    expect(page).to have_content("Star rating: ★★★★☆")    
  end

end

