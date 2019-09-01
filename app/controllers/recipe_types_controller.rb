class RecipeTypesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create show] 
  before_action :admin!, only: %i[new create show]
  
  def show
    @recipe_type = RecipeType.find(params[:id])    
  end

  def new   		
    @recipe_type = RecipeType.new
  end	

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to @recipe_type
    else
      render :new    
    end
  end 

  private

    def recipe_type_params
      params.require(:recipe_type).permit(:name)	
    end

    def admin!
      redirect_to root_path unless current_user.admin?  
    end

end	