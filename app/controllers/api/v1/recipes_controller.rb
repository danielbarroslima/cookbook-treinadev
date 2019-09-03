class Api::V1::RecipesController < Api::V1::ApiController
  # before_action :check_auth, only: %i[destroy accepted reject]

	def index
		@recipes = Recipes.all	
		render json: @recipes ,status: :ok
	end


	def show
		@recipe = Recipe.find(params[:id])
		render json: @recipe , status: :ok
	rescue ActiveRecord::RecordNotFound
		render json: {message: 'Receita não encontrada'}, status: :not_found
	end

	def create
		@recipe = Recipe.new(recipe_params)
	    if @recipe.save
	      render json: @recipe, status: :created
	    else
	      render json: @recipe.errors.full_messages, status: :precondition_failed 
	    end
	end

	def accept
		@recipe = Recipe.find(params[:id]).approved!
		render json: {message:'Receita aprovada'},status: :accepted
	rescue ActiveRecord::RecordNotFound
		render json: {message:'Receita não encontrada'}, status: :not_found
	end

	def reject
		@recipe = Recipe.find(params[:id]).rejected!
		render json: {message:'Receita rejeitada'}, status: :accepted
	rescue 
	end
	
	def destroy
		@recipe = Recipe.find(params[:id]).destroy
		render json:{message:'Receita apagada com sucesso'}, status: :accepted		
	end	

	private

		def recipe_params
	      params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients,:cook_method, :user_id)
	  end

	  # def check_auth
	  #   authenticate_or_request_with_http_basic do |username,password|
	  #     resource = User.find_by_email(username)
	  #     if resource.valid_password?(password)
	  #       sign_in :user, resource
	  #     end
	  #   end
   #  end

end
