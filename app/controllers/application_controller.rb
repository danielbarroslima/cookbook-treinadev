class ApplicationController < ActionController::Base
  before_action :recipe_find, only: %i[ show edit update]
  
  


  private
    def recipe_params
      params.require(:recipe).permit(:title, :recipe_type, :cuisine, :difficulty, :cook_time, :ingredients,:cook_method)
    end

    def recipe_find
      @recipe = Recipe.find(params[:id])
      
    end

    def insert_sucess
      redirect_to @recipe
    end	

end
