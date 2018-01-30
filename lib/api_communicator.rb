require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls,
  page_results_arr.each do |result|
    if result["name"].downcase == character
      return result["films"]
    end
  end
end

def page_results_arr
  url = 'http://www.swapi.co/api/people/'
  all_results_arr = []

  while url != "null" && url
    all_characters = RestClient.get(url)
    character_hash = JSON.parse(all_characters)
    all_results_arr << character_hash["results"]
    url = character_hash["next"]
  end
  all_results_arr.flatten
end

#def page
  #if condition

  #end
#end

# make a web request to each URL to get the info
#  for that film
def parse_character_movies(films_hash)
  films_hash.each do |url|
    film_info = RestClient.get(url)
    parsed_film = JSON.parse(film_info)
    puts parsed_film["title"]
  end
end

# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.
def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
