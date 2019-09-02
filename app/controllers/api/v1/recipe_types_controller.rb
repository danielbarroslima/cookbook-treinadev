class Api::V1::RecipeTypesController < Api::V1::ApiController

  def show 
    @recipe_type = RecipeType.find(params[:id])
    render json: @recipe_type.to_json(include: :recipes), status: :ok
  rescue ActiveRecord::RecordNotFound
  	render json: {message:'Tipo de receita não encontrada'}, status: :not_found	

  end  

  def create
    @recipe_type = RecipeType.new(recipe_types_params)
    if @recipe_type.save
      render json: @recipe_type, status: :created  
    else
      render json: {message: 'O nome não pode ser igual' }, status: :precondition_failed      
    end
  end

private
  def recipe_types_params
    params.require(:recipe_type).permit(:name)
  end 	


end