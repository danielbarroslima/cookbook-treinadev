class Menu < ApplicationRecord
  belongs_to :recipe
  belongs_to :list_recipe
  validates :recipe, uniqueness: {scope: :list_recipe, message: 'this item already exists in this list'}
end
