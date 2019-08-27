class RecipesController < ApplicationController
  before_action :recipe_type_all, only: %i[new create edit update]
  before_action :recipe_find,     only:       %i[show edit update add_to_list] 
  before_action :authenticate_user!, only: %i[new create edit update my_recipes] 

  def index
    @recipes = Recipe.all
  end

  def show
    if user_signed_in?
      @list_recipes  = current_user.list_recipes
      @menu = Menu.new
    end
  end

  def new
  	@recipe = Recipe.new
  end

  def edit
    return redirect_to root_path if current_user != @recipe.user
  end

  def create
  	@recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      insert_sucess_recipe
    else
      insert_fail_recipe
      render :new  
    end
  end

  def update
    return redirect_to root_path if current_user != @recipe.user
    @recipe_type = RecipeType.find(params[:id])
    if @recipe.update(recipe_params)
      insert_sucess_recipe
    else
      insert_fail_recipe  
      render :edit  
    end
  end
  
  def search
    @recipes = Recipe.where('title LIKE ?',"%#{params[:search_recipe]}%")
    if @recipes.empty?
      flash.now[:alert] = 'Nenhuma receita encontrada com este nome'
    end  
  end

  def my_recipes
    @recipes = current_user.recipes    
  end

 def add_to_list
    @list_recipe = ListRecipe.find(params[:menu][:list_recipe_id])
    if @list_recipe.include?(@recipe)
      flash[:notice] = 'Receita já inserida na lista'
      redirect_to @recipe
    else
      Menu.create(list_recipe: @list_recipe, recipe: @recipe)
      flash[:notice] = 'Receita adicionada com sucesso' 
      redirect_to @list_recipe
    end
  end

  private

    def recipe_params
      params.require(:recipe).permit(:title, :recipe_type_id, :cuisine, :difficulty, :cook_time, :ingredients,:cook_method)
    end

    def insert_sucess_recipe
      redirect_to @recipe
    end 

    def insert_fail_recipe
      flash[:notice] = 'Não foi possível salvar a receita'  
    end

    def recipe_find
      @recipe = Recipe.find(params[:id])
    end

    def recipe_type_all
      @recipe_types = RecipeType.all
    end


end
