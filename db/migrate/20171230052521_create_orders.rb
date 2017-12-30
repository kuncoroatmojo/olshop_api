class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :coupon, foreign_key: true
      t.decimal :total
      t.string :status

      t.timestamps
    end
  end
end
