require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative 'lib/cookbook'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @cookbook = Cookbook.new('lib/recipes.csv')
  @recipes = @cookbook.all
  erb :index
end

get '/recipes/:name' do
  @cookbook = Cookbook.new('lib/recipes.csv')
  @recipe = @cookbook.find_by_name(params[:name])
  erb :show
end
