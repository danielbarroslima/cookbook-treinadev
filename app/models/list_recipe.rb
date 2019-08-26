class ListRecipe < ApplicationRecord
  belongs_to :user
  has_many :menus
  has_many :recipes, through: :menus
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}
end
