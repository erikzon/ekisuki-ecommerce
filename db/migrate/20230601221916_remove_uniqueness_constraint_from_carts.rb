class RemoveUniquenessConstraintFromCarts < ActiveRecord::Migration[7.0]
  def change
    remove_index :carts, column: [:user_id, :product_id]
  end
end
