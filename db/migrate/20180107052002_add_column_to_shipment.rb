class AddColumnToShipment < ActiveRecord::Migration[5.1]
  def change
    add_reference :shipments, :order, foreign_key: true
  end
end
