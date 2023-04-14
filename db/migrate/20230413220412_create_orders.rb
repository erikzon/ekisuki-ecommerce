class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :shipping_address
      t.string :phone_number
      t.string :email
      t.string :name
      t.integer :total

      t.timestamps
    end
  end
end
