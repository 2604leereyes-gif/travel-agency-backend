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

ActiveRecord::Schema[7.2].define(version: 2026_06_29_193106) do
  create_table "inquiries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name", null: false
    t.string "phone_number"
    t.string "destination"
    t.date "departure_date"
    t.date "return_date"
    t.integer "number_of_travelers"
    t.decimal "estimated_budget", precision: 12, scale: 2
    t.text "notes"
    t.bigint "travel_package_id"
    t.integer "status", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_inquiries_on_deleted_at"
    t.index ["departure_date"], name: "index_inquiries_on_departure_date"
    t.index ["email"], name: "index_inquiries_on_email"
    t.index ["status"], name: "index_inquiries_on_status"
    t.index ["travel_package_id"], name: "index_inquiries_on_travel_package_id"
  end

  create_table "promos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "details", null: false
    t.boolean "active", null: false
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscribers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.integer "status", default: 0, null: false
    t.string "unsubscribe_token"
    t.datetime "subscribed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_subscribers_on_email", unique: true
    t.index ["unsubscribe_token"], name: "index_subscribers_on_unsubscribe_token", unique: true
  end

  create_table "travel_packages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.decimal "base_price", precision: 10, scale: 2, null: false
    t.boolean "show_price", default: true
    t.integer "number_of_travelers"
    t.string "destination", null: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_days", default: 1, null: false
    t.integer "number_of_nights", default: 0, null: false
    t.datetime "deleted_at"
    t.string "image"
    t.index ["deleted_at"], name: "index_travel_packages_on_deleted_at"
    t.index ["destination"], name: "index_travel_packages_on_destination"
    t.index ["is_active"], name: "index_travel_packages_on_is_active"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
  end

  add_foreign_key "inquiries", "travel_packages"
end
