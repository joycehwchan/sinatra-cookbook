require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    load
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save
  end

  def update(recipe)
    recipe.done = !recipe.done
    save
  end

  private

  def load
    CSV.foreach(@csv_file_path) do |row|
      name = row[0]
      description = row[1]
      rating = row[2]
      done = row[3] == 'true'
      prep_time = row[4]
      recipe = Recipe.new(name, description, rating, done, prep_time)
      @recipes << recipe
    end
  end

  def save
    CSV.open(@csv_file_path, "wb") do |row|
      @recipes.each do |recipe|
        row << [recipe.name,
                recipe.description,
                recipe.rating,
                recipe.done,
                recipe.prep_time]
      end
    end
  end
end
