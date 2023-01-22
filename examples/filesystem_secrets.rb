require './lib/smuggle-env.rb'

puts "This should be nil because we haven't configured anything yet:\n#{ENV['API_PRIVATE_KEY']}"
current_directory = File.expand_path(File.dirname(__FILE__))
backend = Secret_FS.new(base: "#{current_directory}/secrets/")
ENV.start_smuggling(backend: backend)
puts "Trapdoor's been configured! Here's your key:\n#{ENV['API_PRIVATE_KEY']}"
puts "Notice how API_PRIVATE_KEY is absent from ENV.keys:\n#{ENV.keys.inspect}"
