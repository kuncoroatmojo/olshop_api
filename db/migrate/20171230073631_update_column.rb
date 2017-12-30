class UpdateColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :orders, :shipping_id, :shipment
    change_column :orders, :shipment, index:true
  end
end
