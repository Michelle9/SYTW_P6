task :default => :test

desc "Run Server"
  task :rackup do
	sh "rackup"
  end
  
desc "run the chat server"
task :server do
  sh "bundle exec ruby chat.rb"
end  
  
  
desc "Test" 
  task :test do
	sh "ruby spec/test.rb"
  end

