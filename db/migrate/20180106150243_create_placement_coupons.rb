class CreatePlacementCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :placement_coupons do |t|
      t.references :order, foreign_key: true
      t.references :coupon, foreign_key: true

      t.timestamps
    end
  end
end
