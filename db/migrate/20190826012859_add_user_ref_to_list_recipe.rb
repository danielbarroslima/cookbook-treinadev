class AddUserRefToListRecipe < ActiveRecord::Migration[5.2]
  def change
    add_reference :list_recipes, :user, foreign_key: true
  end
end
