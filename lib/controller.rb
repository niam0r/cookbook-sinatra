require_relative 'cookbook'
require_relative 'view'
require_relative '../services/scrape_lets_cook_french'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
    @scraper = ScrapeLetsCookFrenchService.new
  end

  def list
    @view.display(@cookbook.all)
  end

  def create
    recipe_hash = @view.ask_user_for_recipe
    recipe = Recipe.new(recipe_hash[:name], recipe_hash[:description])
    @cookbook.add_recipe(recipe)
  end

  def destroy
    recipe_index = @view.ask_user_for_index
    @cookbook.destroy(recipe_index)
  end

  def mark_as_complete
    recipe_index = @view.ask_user_for_index
    recipe = @cookbook.find(recipe_index)
    recipe.complete!
    @cookbook.save_to_csv
    @cookbook.clear_instance
    @cookbook.load_csv
  end

  def import
    keyword = @view.ask_user_for_keyword
    difficulty = @view.ask_user_for_difficulty
    difficulty ? keyword = keyword + '&dif=' + difficulty : keyword
    scrape_results = @scraper.call(keyword)
    @view.display_scrape(scrape_results)
    index = @view.ask_user_for_index
    recipe = scrape_results[index]
    @cookbook.add_recipe(recipe)
  end
end
