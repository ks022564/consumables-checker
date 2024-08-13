# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_08_05_140116) do
  create_table "companies", charset: "utf8", force: :cascade do |t|
    t.string "company_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", charset: "utf8", force: :cascade do |t|
    t.string "consumable_name", null: false
    t.string "consumable_model_number", null: false
    t.string "consumable_maker", null: false
    t.string "equipment_name", null: false
    t.string "equipment_model_number", null: false
    t.string "serial_number", null: false
    t.integer "inspection_interval", null: false
    t.date "start_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "maintenance_histories", charset: "utf8", force: :cascade do |t|
    t.date "exchange_date", null: false
    t.date "next_maintenance_day", null: false
    t.string "worker", null: false
    t.text "maintenance_comment", null: false
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.index ["item_id"], name: "index_maintenance_histories_on_item_id"
    t.index ["user_id"], name: "index_maintenance_histories_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "company_id"
    t.string "company_name"
    t.index ["email", "company_id"], name: "index_users_on_email_and_company_id", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "maintenance_histories", "items"
  add_foreign_key "maintenance_histories", "users"
end
