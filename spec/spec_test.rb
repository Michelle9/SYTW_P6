require_relative '../chat.rb'
require 'spec_helper.rb'
require 'coveralls'

Coveralls.wear!

describe 'make API call to load path' do
   it "should load the home page" do
      visit 'http://localhost:4567'
      expect(page).to have_content("Chat")
   end
end

describe 'login page' do
   it 'lets the user login' do
      visit 'http://localhost:4567'
      fill_in 'name', :with => 'Hikoreko'
      click_on 'submit'
      page.should have_content('welcome')
   end
end
