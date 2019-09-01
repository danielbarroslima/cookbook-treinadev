class RecipeType < ApplicationRecord
  has_many :recipes 
  validates :name, presence: true, length: {minimum: 3}
  validates :name, uniqueness: {case_sensitive: false}
end
