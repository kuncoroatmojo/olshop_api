class RemoveTrackingCodeFromShipment < ActiveRecord::Migration[5.1]
  def change
    remove_column :shipments, :tracking_code
  end
end
