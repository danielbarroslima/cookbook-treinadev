class RecipesController < ApplicationController

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
      insert_sucess
    else
      insert_fail
      render :new  
    end
  end

  def update
    if @recipe.update(recipe_params)
      insert_sucess
    else
      insert_fail  
      render :edit  
    end
  end
  

  private

    def insert_sucess
      redirect_to @recipe
    end 

    def insert_fail
      flash[:notice] = 'Você deve informar todos os dados da receita'  
    end

end
