require_relative '../chat.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'selenium-webdriver'
require 'rubygems'
require 'rspec'
require 'coveralls'
Coveralls.wear!
ENV['RACK_ENV'] = 'test'

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
       @browser.find_element(:id,"lgout").click
    end
    
    it "4. Should post a message" do
       @browser.find_element(:id, "username").send_keys("Evelpia")
       @browser.manage.timeouts.implicit_wait = 1
       @browser.find_element(:id,"SignIn").click
       @browser.get(@site2)
       @browser.manage.timeouts.implicit_wait = 5
       @browser.find_element(:id, "text").send_keys("Hello World!")
       @browser.find_element(:id, "enviar").click
       @browser.manage.timeouts.implicit_wait = 2
       item = @browser.find_element(:id, "chat").text
       assert_equal("Hello World!", item)
       @browser.find_element(:id,"lgout").click
    end
    
    it "5. Should logout user" do
       @browser.find_element(:id, "username").send_keys("Evelpia")
       @browser.manage.timeouts.implicit_wait = 1
       @browser.find_element(:id,"SignIn").click
       @browser.get(@site2)
       @browser.manage.timeouts.implicit_wait = 5
       @browser.find_element(:id,"lgout").click
       assert_equal(true, @browser.find_element(:id,"SignIn").displayed?)
    end
 end
 
 describe "Testing for coveralls" do
    
    it "Without session init" do
       get '/', {}, 'rack.session' => { :name => 'Testing' }
       expect(last_response).to be_ok
    end
    
    it "With session" do
       get '/'
       expect(last_response).to be_ok
    end
    
    it "Testing post" do
       post '/'
       expect(last_response.to be_ok
    end
    
    it "post with user" do
       post '/', :username => "Testing"
       post '/', :username => "Testing"
       expect(last_response).to be_ok
    end
    
    it "Logout" do
       get '/logout'
       expect(last_response).to be_ok
    end
    
    it "Send with session" do
       get '/send', {}, 'rack.session' => { :name => 'Testing' }
       expect(last_response.body).to eq("Not an ajax request")
    end
    
    it "Send with HTTP_X_REQUESTED_WITH session" do
       get '/send', {}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest" ,'rack.session' => { :name => 'Testing' }}
       expect(last_response.body).to eq("")
    end
    
    it "Send without session" do
       get '/send',env = {}
       except(last_response.body).to eq("")
    end
    
    it "Update" do
       get'/update'
       expect(last_response.body).to eq("Not an ajax request")
    end
    
    it "HTTP_X_REQUESTED_WITH Update" do
		get '/update',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
		expect(last_response).to be_ok
	end
	
	it "Get user" do
	    get '/user'
	    expect(last_response.body).to eq("Not an ajax request")
	end
	
	it "User with HTTP_X_REQUESTED_WITH" do
		get '/user',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
		expect(last_response).to be_ok
	end
	
	it "chat update" do
		get '/chat/update'
		expect(last_response.body).to eq("Not an ajax request")
	end

	it "chat update with HTTP_X_REQUESTED_WITH" do
		get '/chat/update',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
		expect(last_response).to be_ok
	end
 end
