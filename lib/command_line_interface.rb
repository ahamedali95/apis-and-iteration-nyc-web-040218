require 'pry'
require 'json'
require 'rest-client'

def welcome
  puts "Welcome!"
end

def get_character_from_user
  puts "please enter a character"
  gets.chomp.downcase
end
