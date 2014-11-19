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
	   @site2 = 'http://desolate-shelf-1169.herokuapp.com/chat'
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
       @browser.manage.timeouts.implicit_wait = 1
       @browser.find_element(:id,"SignIn").click
       @browser.get(@site2)
       @browser.manage.timeouts.implicit_wait = 5
       assert_equal(true, @browser.find_element(:id,"enviar").displayed?)
    end
    
    it "4. Should post a message" do
       @browser.find_element(:id, "username").send_keys("Evelpia")
       @browser.manage.timeouts.implicit_wait = 1
       @browser.find_element(:id,"SignIn").click
       @browser.get(@site2)
       @browser.manage.timeouts.implicit_wait = 5
       assert_equal(true, @browser.find_element(:id,"enviar").displayed?)
    end
 end
