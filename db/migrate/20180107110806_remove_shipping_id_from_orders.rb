class RemoveShippingIdFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :shipping_id
  end
end
