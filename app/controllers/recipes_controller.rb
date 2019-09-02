class RecipesController < ApplicationController
  before_action :recipe_type_all, only: %i[new create edit update]
  before_action :cuisine_all, only: %i[new create edit update]
  before_action :authenticate_user!, only: %i[new create edit update my_recipes] 
  before_action :not_admin, only: %i[accept pending reject]
  before_action :recipe_find, only: %i[show edit update add_to_list] 


  def index
    @recipes = Recipe.approved
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
      render :new  
    end
  end

  def update
    return redirect_to root_path if current_user != @recipe.user
    if @recipe.update(recipe_params)
       @recipe.pending! 
      insert_sucess_recipe
    else
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
      redirect_to @recipe
      flash[:notice] = 'Receita já estava nesta lista' 
    else
      Menu.create(list_recipe: @list_recipe, recipe: @recipe)
      flash[:notice] = 'Receita adicionada com sucesso' 
      redirect_to @list_recipe
    end
  end

  def pending
    @recipes = Recipe.pending
  end

  def accept
    Recipe.find(params[:id]).approved!
    flash[:notice] = 'Receita aprovada'
    redirect_to pending_recipes_path
  end

  def reject
     Recipe.find(params[:id]).rejected!
    flash[:notice] = 'Receita rejeitada'
    redirect_to pending_recipes_path
  end

  private

    def recipe_params
      params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients,:cook_method, :user_id)
    end

    def insert_sucess_recipe
      redirect_to @recipe
    end 

    def recipe_find
      @recipe = Recipe.find(params[:id])
    end

    def recipe_type_all
      @recipe_types = RecipeType.all
    end

    def cuisine_all
      @cuisines = Cuisine.all      
    end

    def not_admin
      return redirect_to root_path unless current_user.admin? 
    end


end
