# IMPORTANT: DO NOT MODIFY THIS FILE.
# To complete this assignment you only need to modify
# the files inside the individual /episode-xx/ folders.
# You may, however, take a look inside this file to see
# how the entire program works. Ideally though, you'll
# only need to work with the files inside the individual
# /episode-xx/ folders to fix the replicator each episode.

class Validator

  attr_reader :temperature, :ingredients

  def initialize(glass, recipe)
    @recipe = recipe
    validate!(glass)
  end

  def valid?(glass)
    validate!(glass)
    glass.errors.size == 0
  end

  def validate!(glass)

    glass.errors = []

    glass.errors << 'This is too hot!'  if glass.temperature > @recipe.temperature
    glass.errors << 'This is too cold!' if glass.temperature < @recipe.temperature

    recipe_ingredients_not_in_glass = glass.ingredients - @recipe.ingredients
    glass_ingredients_not_in_recipe = @recipe.ingredients - glass.ingredients
    different_ingredients = recipe_ingredients_not_in_glass | glass_ingredients_not_in_recipe
    if different_ingredients.size > 0
      glass.errors << "That has #{humanize_ingredient_list(glass.ingredients)} in it!"
      glass.errors << "It should have #{humanize_ingredient_list(@recipe.ingredients)} in it!"
    end
  end

  def humanize_ingredient_list(ingredients_arr)
    if ingredients_arr.size > 0
      ingredients_str = ingredients_arr.join (', ')
      change_last_comma_to_and(ingredients_str)
    else
      'nothing'
    end
  end

  def change_last_comma_to_and(ingredients_str)
    ingredients_str.reverse.sub(',', '& ').reverse
  end

end
