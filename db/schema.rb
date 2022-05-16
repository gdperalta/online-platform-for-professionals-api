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

ActiveRecord::Schema.define(version: 2022_05_16_092843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "professional_id", null: false
    t.bigint "client_id", null: false
    t.boolean "client_showed_up"
    t.string "event_uuid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "no_show_link"
    t.string "invitee_link"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "finished"
    t.index ["client_id"], name: "index_bookings_on_client_id"
    t.index ["professional_id"], name: "index_bookings_on_professional_id"
  end

  create_table "calendly_tokens", force: :cascade do |t|
    t.bigint "professional_id", null: false
    t.string "authorization", null: false
    t.string "user", null: false
    t.string "organization", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["professional_id"], name: "index_calendly_tokens_on_professional_id"
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "connections", force: :cascade do |t|
    t.bigint "professional_id", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "classification", null: false
    t.index ["client_id"], name: "index_connections_on_client_id"
    t.index ["professional_id"], name: "index_connections_on_professional_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "professionals", force: :cascade do |t|
    t.bigint "user_id"
    t.string "field"
    t.string "license_number"
    t.string "office_address", default: ""
    t.text "headline", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_professionals_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "professional_id", null: false
    t.bigint "client_id", null: false
    t.integer "rating"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_reviews_on_client_id"
    t.index ["professional_id"], name: "index_reviews_on_professional_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "professional_id", null: false
    t.string "title"
    t.text "details"
    t.float "min_price"
    t.float "max_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["professional_id"], name: "index_services_on_professional_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "contact_number", null: false
    t.string "city", default: "", null: false
    t.string "region", default: "", null: false
    t.string "role", default: "", null: false
    t.boolean "approved", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_portfolios", force: :cascade do |t|
    t.bigint "professional_id", null: false
    t.string "title"
    t.text "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["professional_id"], name: "index_work_portfolios_on_professional_id"
  end

  add_foreign_key "bookings", "clients"
  add_foreign_key "bookings", "professionals"
  add_foreign_key "calendly_tokens", "professionals"
  add_foreign_key "clients", "users"
  add_foreign_key "connections", "clients"
  add_foreign_key "connections", "professionals"
  add_foreign_key "reviews", "clients"
  add_foreign_key "reviews", "professionals"
  add_foreign_key "services", "professionals"
  add_foreign_key "work_portfolios", "professionals"
end
