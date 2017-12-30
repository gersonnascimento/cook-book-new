class RemoveRecipeTypeFromRecipe < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :recype_type, :string
  end
end
