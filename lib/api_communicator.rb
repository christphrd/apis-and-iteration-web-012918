require 'rest-client'
require 'json'
require 'pry'

=begin
def get_character_movies_from_api(character)
  page_results_arr.each do |result|
    if result["name"].downcase == character
      return result["films"]
    end
  end
end
=end

def get_character_movies_from_api(character)
  url = 'http://www.swapi.co/api/people/'
  correct_results = nil

  until correct_results
    all_characters = RestClient.get(url)
    character_hash = JSON.parse(all_characters)
    page_results_arr = character_hash["results"]
    page_results_arr.each do |result|
      if result["name"].downcase == character
        return result["films"]
      end
    end
    url = character_hash["next"]
  end
end

def parse_character_movies(films_hash)
  films_hash.each do |url|
    film_info = RestClient.get(url)
    parsed_film = JSON.parse(film_info)
    puts parsed_film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
