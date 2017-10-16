require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @cookbook = []
    load_csv
  end

  def all
    @cookbook
  end

  def add_recipe(recipe)
    @cookbook << recipe
    save_to_csv
  end

  def destroy(recipe_index)
    @cookbook.delete_at(recipe_index)
    save_to_csv
  end

  def clear_instance
    @cookbook.clear
  end

  def find(recipe_index)
    @cookbook[recipe_index]
  end

  def find_by_name(name)
    r = @cookbook.find { |r| r.name.downcase.gsub(' ', '_') == name }
    p r
    r
  end

  def destroy_all
    @cookbook.clear
    save_to_csv
  end

  def load_csv
    CSV.foreach(@csv_file_path) do |recipe|
      @cookbook << Recipe.new(recipe[0], recipe[1], recipe[2], recipe[3])
    end
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @cookbook.each do |recipe|
        csv.puts([recipe.completed, recipe.name, recipe.description, recipe.cooking_time])
      end
    end
  end
end
