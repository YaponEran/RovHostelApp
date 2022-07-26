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

ActiveRecord::Schema.define(version: 2022_09_08_091806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: :cascade do |t|
    t.string "build_title", null: false
    t.string "build_postcode", null: false
    t.string "address", null: false
    t.string "phone_number", null: false
    t.bigint "hotel_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotel_id"], name: "index_buildings_on_hotel_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "title", null: false
    t.string "adress", null: false
    t.string "postcode", null: false
    t.string "phone_number", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_hotels_on_title", unique: true
    t.index ["user_id"], name: "index_hotels_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.bigint "role_id"
    t.string "subject", null: false
    t.string "action", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action"], name: "index_permissions_on_action"
    t.index ["role_id", "subject", "action"], name: "index_permissions_on_role_id_and_subject_and_action", unique: true
    t.index ["role_id"], name: "index_permissions_on_role_id"
    t.index ["subject"], name: "index_permissions_on_subject"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role_rank", default: 0
    t.index ["title"], name: "index_roles_on_title", unique: true
  end

  create_table "rooms", force: :cascade do |t|
    t.string "overnight_kind", null: false
    t.integer "total_room", default: 0, null: false
    t.integer "total_bed", default: 0, null: false
    t.boolean "has_air_con", default: false, null: false
    t.boolean "has_kitchen", default: false, null: false
    t.boolean "has_bath", default: false, null: false
    t.boolean "has_wifi", default: false, null: false
    t.bigint "building_id", null: false
    t.decimal "price", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["building_id"], name: "index_rooms_on_building_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "mobile_phone", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "role_id"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "buildings", "hotels"
  add_foreign_key "hotels", "users"
  add_foreign_key "permissions", "roles"
  add_foreign_key "rooms", "buildings"
  add_foreign_key "users", "roles"
end
