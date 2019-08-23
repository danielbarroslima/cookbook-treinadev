class RecipeTypesController < ApplicationController
  before_action :recipe_type_new, only: %i[new create]
  def show
    @recipe_type = RecipeType.find(params[:id])    
  end

  def new   		
  end	

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to @recipe_type
    else
      flash[:alert] = 'Tipo de receita já inserido no sistema,tente outro nome'
      render :new    
    end
  end 


  private
    def recipe_type_params
      params.require(:recipe_type).permit(:name)	
    end

    def recipe_type_new
      @recipe_type = RecipeType.new 
    end


end	