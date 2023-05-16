class AddSizeToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :size, :string, null: true
  end
end
