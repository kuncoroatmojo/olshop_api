# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180107110943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.date "valid_start"
    t.date "valid_end"
    t.integer "quantity"
    t.decimal "amount"
    t.string "amount_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "coupon_id"
    t.decimal "total"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "shipment_id"
    t.text "address"
    t.string "phone"
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["shipment_id"], name: "index_orders_on_shipment_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "payment_method"
    t.text "proof"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "placement_coupons", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_placement_coupons_on_coupon_id"
    t.index ["order_id"], name: "index_placement_coupons_on_order_id"
  end

  create_table "placements", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 0
    t.index ["order_id"], name: "index_placements_on_order_id"
    t.index ["product_id"], name: "index_placements_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipments", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.index ["order_id"], name: "index_shipments_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "password"
    t.string "user_type"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
  end

  add_foreign_key "orders", "coupons"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "orders"
  add_foreign_key "placement_coupons", "coupons"
  add_foreign_key "placement_coupons", "orders"
  add_foreign_key "placements", "orders"
  add_foreign_key "placements", "products"
  add_foreign_key "shipments", "orders"
end
