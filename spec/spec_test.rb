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
      within("#username") do
        fill_in('name', :with => 'Hikoreko')
      end
      click_on('Sing In')
      expect(page).to have_content("Hikoreko")
      #page.should have_content('welcome..')
   end
end

describe 'chat page' do
   it 'load chat fine' do
      visit 'http://localhost:4567/chat'
      expect(page).to have_content("welcome..")
      expect(page).to have_content("Logout")
      expect(page).to have_content("Enviar")
      expect(page).to have_content("Usuarios Conectados")
   end
end


