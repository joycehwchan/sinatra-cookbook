require_relative 'models/recipe'
require_relative 'models/cookbook'
require_relative 'models/scrape_service'

require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
set :bind, "0.0.0.0"

cookbook = Cookbook.new('models/recipes.csv')

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

get "/" do
  @recipes = cookbook.all
  erb :index
end

get "/recipe/:id" do
  @recipe = cookbook.all[params[:id].to_i]
  erb :recipe
end

# get #new(form)

post "/" do
  # raise
  @recipe = Recipe.new(params[:name], params[:description], params[:rating], params[:done], params[:prep_time])
  cookbook.add_recipe(@recipe)
  @recipes = cookbook.all
  erb :index
end
