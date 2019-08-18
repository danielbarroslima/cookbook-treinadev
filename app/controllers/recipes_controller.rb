class RecipesController < ApplicationController
  before_action :recipe_find, only: %i[ show edit update]
  def index
    @recipes = Recipe.all
  end

  def show
    # @recipe = Recipe.find(params[:id])
  end

  def new
  	@recipe = Recipe.new  	
  end

  def edit
  end

  def create
  	@recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      render :new  
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit  
      
    end
    
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title, :recipe_type, :cuisine, :difficulty, :cook_time, :ingredients,:cook_method)
    end

    def recipe_find
      @recipe = Recipe.find(params[:id])
      
    end
end
