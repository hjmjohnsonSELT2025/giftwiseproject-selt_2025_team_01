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

ActiveRecord::Schema[7.1].define(version: 2025_12_03_194742) do
  create_table "event_recipients", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "recipient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "recipient_id"], name: "index_event_recipients_on_event_id_and_recipient_id", unique: true
    t.index ["event_id"], name: "index_event_recipients_on_event_id"
    t.index ["recipient_id"], name: "index_event_recipients_on_recipient_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.date "date"
    t.text "description"
    t.string "theme"
    t.decimal "budget"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.integer "age"
    t.string "occupation"
    t.text "hobbies"
    t.text "likes"
    t.text "dislikes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.string "relationship"
    t.text "hobbies"
    t.text "dislikes"
    t.index ["user_id"], name: "index_recipients_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "event_recipients", "events"
  add_foreign_key "event_recipients", "recipients"
  add_foreign_key "events", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "recipients", "users"
end
