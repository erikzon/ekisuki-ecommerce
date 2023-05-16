class AddIsClothesToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :isClothes, :boolean, default: false
  end
end
