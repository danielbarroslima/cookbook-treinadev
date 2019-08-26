class Menu < ApplicationRecord
  belongs_to :recipe
  belongs_to :list_recipe
end
