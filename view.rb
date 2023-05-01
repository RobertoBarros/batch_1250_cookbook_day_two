class View

  def display_list(recipes)
    recipes.each_with_index do |recipe, index|
      done = recipe.done? ? '[X]' : '[ ]'
      puts "#{index + 1} #{done} - #{recipe.name}: #{recipe.description} - Rating: #{recipe.rating} | Prep. Time: #{recipe.prep_time}"
    end
  end

  def display_recipe_names(recipe_names)
    recipe_names.each_with_index do |name, index|
      puts "#{index + 1} - #{name}"
    end
  end

  def ask_name
    puts "Enter recipe name:"
    gets.chomp
  end

  def ask_description
    puts "Enter recipe description:"
    gets.chomp
  end

  def ask_rating
    puts "Enter recipe rating:"
    gets.chomp
  end

  def ask_prep_time
    puts "Enter preparation time:"
    gets.chomp
  end

  def ask_ingredient
    puts "Enter ingredient to import:"
    gets.chomp
  end

  def ask_index
    puts "Enter recipe number:"
    gets.chomp.to_i - 1
  end
end
