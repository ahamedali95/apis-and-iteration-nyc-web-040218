require 'rest-client'
require 'json'
require 'pry'
require_relative "../lib/command_line_interface.rb"

def get_character_movies_from_api(character)
  counter = 1

  while counter < 10
    all_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{counter}")
    character_hash = JSON.parse(all_characters)

      character_hash["results"].each do |characterHash|
        if characterHash["name"] == format_string(character)
          films = characterHash["films"]
          return films
        elsif characterHash["name"] == character.upcase
          films = characterHash["films"]
          return films
        end
      end

      counter += 1
  end

  return nil
end



def show_character_movies(character)
  json_apis = get_character_movies_from_api(character)

  if json_apis == nil
    puts "ERROR - enter a real character."
    return repeat()
  end

  json_apis.map do |json_api|
    film_hash = json_api_to_hash(json_api)
    film_hash["title"]
  end
end


def json_api_to_hash(json_api)
  films = RestClient.get(json_api)
  JSON.parse(films)
end

def format_string(string)
  formatted_string = ""

  names = string.split(" ")
  names.each_with_index do |name, index|
    if index == names.length - 1
      formatted_string += name[0].capitalize() + name.slice(1, name.length)
    else
      formatted_string += name[0].capitalize() + name.slice(1, name.length) + " "
    end
  end

    formatted_string
end

def repeat()
  character = get_character_from_user()
  puts show_character_movies(character)
end
