class AddRecipeAndListRecipeToMenu < ActiveRecord::Migration[5.2]
  def change
    add_reference :menus, :recipe, foreign_key: true
    add_reference :menus, :list_recipe, foreign_key: true
  end
end
