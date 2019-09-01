class ListRecipe < ApplicationRecord
  belongs_to :user
  has_many :menus
  has_many :recipes, through: :menus
  validates :name, presence: true, length:{minimum: 3}
  validates :name, uniqueness: {scope: :user, message: 'already exists'}
  
  def include?(recipe)
    self.recipes.include?(recipe)
  end 
  
  

end
