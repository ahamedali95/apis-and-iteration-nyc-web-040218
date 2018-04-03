rrequire 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

    character_hash["results"].each do |characterHash|
      if characterHash["name"] == format_string(character)
        films = characterHash["films"]
        return films
      elsif characterHash["name"] == character.upcase
        films = characterHash["films"]
        return films
      else
        return nil
      end
    end
end

def show_character_movies(character)
  json_apis = get_character_movies_from_api(character)
  all_titles = []

  if json_apis == nil
    return "ERROR - enter a real character."
  end

  json_apis.each do |json_api|
    film_hash = json_api_to_hash(json_api)
    all_titles << film_hash["title"]
  end

  all_titles
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
