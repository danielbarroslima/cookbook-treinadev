class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes
  has_many :list_recipes

  enum role: {user: 0, admin: 7}
      
  def validation_list_include(list_recipe)
    return self.list_recipes.include?(list_recipe)
  end         
end
