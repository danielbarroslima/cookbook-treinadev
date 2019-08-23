class RecipesController < ApplicationController
  before_action :recipe_type_all, only: %i[new create edit update]
  before_action :recipe_find,     only:       %i[show edit update]  

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
  	@recipe = Recipe.new
  end

  def edit
  end

  def create
  	@recipe = Recipe.new(recipe_params)
    if @recipe.save
      insert_sucess_recipe
    else
      insert_fail_recipe
      render :new  
    end
  end

  def update
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



    def recipe_type_params
      params.require(:recipe_type).permit(:name)
    end

    def recipe_type_all
      @recipe_types = RecipeType.all
    end
end
