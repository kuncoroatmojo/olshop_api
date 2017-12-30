class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    #remove_column :orders, :shipping_id
    add_reference :orders, :shipment, index:true
  end
end
