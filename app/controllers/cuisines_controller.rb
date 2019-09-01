class CuisinesController < ApplicationController
  before_action :authenticate_user!, only: %i[index show new create] 
  before_action :admin!, only: %i[index show new create ]
  def index
  	@cuisines = Cuisine.all
  	
  end

  def show
  	@cuisine = Cuisine.find(params[:id])
  	
  end

  def new
  	@cuisine = Cuisine.new
  end

  def create
  	@cuisine = Cuisine.new(cuisine_params)
  	if @cuisine.save
  	  redirect_to @cuisine
  	else
  	  render :new  		
  	end
  	
  end

  private
  
  	def cuisine_params
  		params.require(:cuisine).permit(:name)
  	end

  	def admin!
      redirect_to root_path unless current_user.admin?  
    end

end
