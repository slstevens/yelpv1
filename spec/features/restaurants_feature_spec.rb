require 'rails_helper'

describe 'restaurants' do
	context 'no restaurants have been added' do
		it 'should display a prompt to add a restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'No restaurants'
			expect(page).to have_link 'Add a restaurant'
		end
	end

	context 'restaurants have been added' do
		before do
			Restaurant.create(name: 'KFC')
		end
		it 'should display restaurants' do
			visit '/restaurants'
			expect(page).to have_content('KFC')
			expect(page).not_to have_content('No restaurants yet')
		end
	end

	context 'viewing restaurants' do
		before do
			@kfc = Restaurant.create(name:'KFC')
		end

		it 'lets a user view a restaurant' do
			visit '/restaurants'
			click_link 'KFC'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq "/restaurants/#{@kfc.id}"
		end

	end

	context 'editing restaurants' do

		before do
			test_user = User.create(email: "sean@makers.com", password: "12345678", password_confirmation: "12345678")
			login_as test_user
			visit('/')
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
		end

		it 'lets a user edit a restaurant' do
			visit '/'
			click_link 'Edit KFC'
			fill_in 'Name', with: 'Kentucky Fried Chicken'
			click_button 'Update Restaurant' #changed from click
			expect(page).to have_content 'Kentucky Fried Chicken'
			expect(current_path).to eq '/restaurants'
		end

	end

end

describe 'creating restaurants' do

	before do
		test_user = User.create(email: "sean@makers.com", password: "12345678", password_confirmation: "12345678")
		login_as test_user
	end


	it 'prompts user to fill out a form, then displays the new restaurant' do
		visit '/restaurants'
		click_link 'Add a restaurant'
		fill_in 'Name', with: 'KFC'
		click_button 'Create Restaurant'
		expect(page).to have_content 'KFC'
		expect(current_path).to eq '/restaurants'
	end

	context 'an invalid restaurant' do
		it 'does not let you submit a name that is too short' do
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'kf'
			click_button 'Create Restaurant'
			expect(page).not_to have_css 'h2', text: 'kf'
		end
	end
end


describe 'deleting restaurants when logged in' do

	before do
		# Restaurant.create(name:'KFC')
		test_user = User.create(email: "sean@makers.com", password: "12345678", password_confirmation: "12345678")
		login_as test_user
		visit '/restaurants'
		click_link 'Add a restaurant'
		fill_in 'Name', with: 'KFC'
		click_button 'Create Restaurant'
		expect(page).to have_content 'KFC'
	end

	it "removes a restaurant when a user clicks a delete link" do
		visit '/restaurants'
		click_link 'Delete KFC'
		expect(page).not_to have_content 'KFC'
		expect(page).to have_content 'Restaurant deleted successfully'
	end

end

