class Recipe
  attr_accessor :name, :description, :rating, :done, :prep_time

  def initialize(name, description, rating, done = false, prep_time)
    @name = name
    @description = description
    @rating = rating
    @done = done
    @prep_time = prep_time
  end
end
