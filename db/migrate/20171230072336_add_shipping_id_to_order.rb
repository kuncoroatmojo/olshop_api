class AddShippingIdToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :shipping_id, :string
  end
end
