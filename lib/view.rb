require_relative 'cookbook'

class View
  def display(cookbook)
    cookbook.each_with_index do |recipe, index|
      puts "#{index + 1} - [#{recipe.completed == 'true' ? 'X' : ' '}] #{recipe.name} - #{recipe.cooking_time}"
    end
  end

  def display_scrape(results_a)
    puts "recipes found:"
    results_a.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name} - #{recipe.cooking_time}"
    end
  end

  def ask_user_for_recipe
    recipe = {}
    puts "What is the name of the recipe"
    recipe[:name] = gets.chomp
    puts "What is the description of the recipe"
    recipe[:description] = gets.chomp
    recipe
  end

  def ask_user_for_index
    puts "Index?"
    return gets.chomp.to_i - 1
  end

  def ask_user_for_keyword
    puts "Keyword?"
    return gets.chomp
  end

  def ask_user_for_difficulty
    puts "Difficulty? (1, 2, 3 or 4 or press enter to search all"
    return gets.chomp
  end
end
