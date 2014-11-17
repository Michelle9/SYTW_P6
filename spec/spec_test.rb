require_relative '../chat.rb'
require 'spec_helper.rb'
require 'coveralls'

Coveralls.wear!

describe 'make API call to load path' do
   it "should load the home page" do
      visit 'http://localhost:4567'
      expect(page).to have_content("welcome")
   end
end
