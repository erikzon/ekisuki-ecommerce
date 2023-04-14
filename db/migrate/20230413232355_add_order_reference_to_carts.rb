class AddOrderReferenceToCarts < ActiveRecord::Migration[7.0]
  def change
    add_reference :carts, :order, null: true, foreign_key: true, name: 'sold_on_order'
  end
end
