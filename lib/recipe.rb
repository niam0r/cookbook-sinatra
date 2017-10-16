class Recipe
  attr_accessor :name, :description, :completed, :cooking_time

  def initialize(completed = false, name, description, cooking_time)
    # change to get hash instead of array of parameters
    @name = name
    @description = description
    @completed = completed
    @cooking_time = cooking_time
  end

  def complete!
    @completed = true
  end
end
