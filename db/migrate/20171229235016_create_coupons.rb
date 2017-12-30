class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.date :valid_start
      t.date :valid_end
      t.integer :quantity
      t.decimal :amount
      t.string :amount_type

      t.timestamps
    end
  end
end
