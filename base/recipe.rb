# IMPORTANT: DO NOT MODIFY THIS FILE.
# To complete this assignment you only need to modify
# the files inside the individual /episode-xx/ folders.
# You may, however, take a look inside this file to see
# how the entire program works. Ideally though, you'll
# only need to work with the files inside the individual
# /episode-xx/ folders to fix the replicator each episode.

class Recipe

  attr_reader :name, :temperature, :ingredients

  def initialize(recipe)
    @name        = recipe['name']
    @temperature = recipe['temperature'].to_i
    @ingredients = recipe['ingredients']
  end

end
