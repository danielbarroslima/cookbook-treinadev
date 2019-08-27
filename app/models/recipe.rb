class Recipe < ApplicationRecord
  belongs_to :recipe_type	
  belongs_to :user
  has_many :menus
  has_many :list_recipes, through: :menus
  enum status: { pending: 0 , approved: 12, rejected:22 }
  validates :title, :recipe_type_id, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method, presence: true	
  def cook_time_min
    "#{cook_time} minutos"
  end

  def owner?(user)
  	self.user == user  	
  end
end
