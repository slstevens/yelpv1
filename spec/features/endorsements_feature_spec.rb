require 'rails_helper'

describe 'endorsing reviews' do

	before do
		kfc = Restaurant.create(name: 'KFC')
		kfc.reviews.create(rating: 3, thoughts: "It was an abomination")
	end

	it 'a user can endorse a review, which updates the review endorsement count', js: true do
		visit '/restaurants'
		click_link 'Endorse'
		expect(page).to have_content('Endorsements: 1')
	end
end
