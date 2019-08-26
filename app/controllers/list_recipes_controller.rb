class ListRecipesController < ApplicationController
	before_action :authenticate_user!, only: %i[index show new create]
	def index
	  @list_recipes = ListRecipe.all
	end

	def show
	  @list_recipe = ListRecipe.find(params[:id])
	end

	def new
	  @list_recipe = ListRecipe.new
	end

	def create
	  @list_recipe = ListRecipe.create(list_recipe_params)
	  @list_recipe.user = current_user
	  if @list_recipe.save
	  	redirect_to @list_recipe
	  else
	  	flash[:notice] = 'O nome não pode ser repetido um deixado em branco'
	  	render :new		
	  end	
		
	end

	private

	  def list_recipe_params
	  	params.require(:list_recipe).permit(:name)
	  	
	  end
end	