require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # Pegar todas as receitas
    recipes = @cookbook.all

    # Mandar a view mostrar as receitas
    @view.display_list(recipes)
  end

  def add
    # Perguntar o nome da receita
    name = @view.ask_name
    # Perguntar a descrição da receita
    description = @view.ask_description

    # Perguntar a nota da receita
    rating = @view.ask_rating

    # Perguntar o tempo de preparo
    prep_time = @view.ask_prep_time

    # Criar uma instância de Recipe
    recipe = Recipe.new(name, description, rating, prep_time)

    # Criar a receita no cookbook
    @cookbook.create(recipe)
  end

  def remove
    # Mostrar todas receitas
    list

    # Perguntar o número da receita a ser removida
    index = @view.ask_index

    # Mandar o cookbook apagar a receita pelo index
    @cookbook.destroy(index)
  end

  def mark_as_done
    # Mostrar as receitas
    list

    # Perguntar o index da receita a ser marcada
    index = @view.ask_index

    # Pegar a receita pelo index
    recipe = @cookbook.all[index]

    # Marcar como feita
    recipe.done!

    # Salvar no CSV
    @cookbook.save_csv

  end

  def import
    # Perguntar o ingrediente
    ingredient = @view.ask_ingredient

    # Criamos a instância do serviço de scrapping
    scrapping = ScrappingService.new(ingredient)

    # Pedimos a lista de nomes de receitas
    recipe_names = scrapping.list

    # Mostramos os nomes
    @view.display_recipe_names(recipe_names)

    # Perguntar qual o número da receita a importar
    index = @view.ask_index

    # O serviço de scrapping importa pelo index
    recipe = scrapping.import(index)

    # adiciona a nova receita ao cookbook
    @cookbook.create(recipe)


  end

end
