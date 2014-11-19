require_relative '../chat.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'selenium-webdriver'
require 'rubygems'
require 'coveralls'
Coveralls.wear!

include Rack::Test::Methods

def app
   Sinatra::Application
end

describe "Testing Chat App" do

	before :all do
	   @browser = Selenium::WebDriver.for :firefox
	   @site = 'http://desolate-shelf-1169.herokuapp.com/'
	   @browser.get(@site)
	   @browser.manage.timeouts.implicit_wait = 5
	end
	
	after :all do
	   @browser.quit
	end
	
	it "1. Should load the home page" do
      assert_equal(@site, @browser.current_url)
    end
    
    it "2. Should see home page" do
       item = @browser.find_element(:id,"loginp").text
       assert_equal("Práctica 6 - Chat", item)
    end
    
    it "3. Should login with a nick" do
       @browser.find_element(:id, "username").send_keys("Evelpia")
       @browser.manage.timeouts.implicit_wait = 3
       @browser.find_element(:id,"SignIn").click
       @browser.manage.timeouts.implicit_wait = 5
       assert_equal(true, @browser.find_element(:id,"enviar").display?)
    end
    
    #it "4. Should post a message" do
    #   fill_in 'text', :with => 'Hello!!'
    #   click_on('Enviar')
    #   expect(page).to have_content("Hello!!")
    #end
 end
