# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_22_192511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documentations", force: :cascade do |t|
    t.string "name"
    t.string "doc_type"
    t.string "path"
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vehicle_id"], name: "index_documentations_on_vehicle_id"
  end

  create_table "fuels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoice_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.date "date"
    t.integer "km"
    t.string "invoice_ref"
    t.bigint "invoice_type_id", null: false
    t.text "remarks"
    t.float "price"
    t.bigint "vehicle_id", null: false
    t.bigint "shop_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_type_id"], name: "index_invoices_on_invoice_type_id"
    t.index ["shop_id"], name: "index_invoices_on_shop_id"
    t.index ["vehicle_id"], name: "index_invoices_on_vehicle_id"
  end

  create_table "maintenance_plans", force: :cascade do |t|
    t.text "task"
    t.text "details"
    t.integer "interval_km"
    t.integer "interval_months"
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vehicle_id"], name: "index_maintenance_plans_on_vehicle_id"
  end

  create_table "maintenances", force: :cascade do |t|
    t.date "date"
    t.integer "km"
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vehicle_id"], name: "index_maintenances_on_vehicle_id"
  end

  create_table "operations", force: :cascade do |t|
    t.text "task"
    t.text "details"
    t.bigint "maintenance_id", null: false
    t.bigint "maintenance_plan_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["maintenance_id"], name: "index_operations_on_maintenance_id"
    t.index ["maintenance_plan_id"], name: "index_operations_on_maintenance_plan_id"
  end

  create_table "refuels", force: :cascade do |t|
    t.date "date"
    t.float "km"
    t.float "quantity"
    t.float "price"
    t.bigint "fuel_id", null: false
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fuel_id"], name: "index_refuels_on_fuel_id"
    t.index ["vehicle_id"], name: "index_refuels_on_vehicle_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.string "task"
    t.integer "creation_km"
    t.integer "limit_km"
    t.date "limit_date"
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vehicle_id"], name: "index_reminders_on_vehicle_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "tel"
    t.string "home_url"
    t.string "booking_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicle_fuels", force: :cascade do |t|
    t.bigint "fuel_id", null: false
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fuel_id"], name: "index_vehicle_fuels_on_fuel_id"
    t.index ["vehicle_id"], name: "index_vehicle_fuels_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.string "registration"
    t.string "sn"
    t.integer "tank_capacity"
    t.integer "actual_km"
    t.float "total_expenses"
    t.date "purchase_date"
    t.integer "purchase_km"
    t.date "sale_date"
    t.integer "sale_km"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "documentations", "vehicles"
  add_foreign_key "invoices", "invoice_types"
  add_foreign_key "invoices", "shops"
  add_foreign_key "invoices", "vehicles"
  add_foreign_key "maintenance_plans", "vehicles"
  add_foreign_key "maintenances", "vehicles"
  add_foreign_key "operations", "maintenance_plans"
  add_foreign_key "operations", "maintenances"
  add_foreign_key "refuels", "fuels"
  add_foreign_key "refuels", "vehicles"
  add_foreign_key "reminders", "vehicles"
  add_foreign_key "vehicle_fuels", "fuels"
  add_foreign_key "vehicle_fuels", "vehicles"
  add_foreign_key "vehicles", "users"
end
