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

ActiveRecord::Schema.define(version: 2019_10_06_135544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_to_schedules", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "schedule_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_artist_to_schedules_on_artist_id"
    t.index ["schedule_id"], name: "index_artist_to_schedules_on_schedule_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_artists_on_name"
  end

  create_table "music_bars", force: :cascade do |t|
    t.string "name", null: false
    t.string "place", null: false
    t.string "hp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_music_bars_on_name"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "music_bar_id", null: false
    t.string "title", null: false
    t.datetime "event_date", null: false
    t.text "info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_date"], name: "index_schedules_on_event_date"
    t.index ["music_bar_id"], name: "index_schedules_on_music_bar_id"
    t.index ["title"], name: "index_schedules_on_title"
  end

  create_table "user_to_schedules", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "schedule_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["schedule_id"], name: "index_user_to_schedules_on_schedule_id"
    t.index ["user_id"], name: "index_user_to_schedules_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "access_token_hash", null: false
    t.string "refresh_token_hash", null: false
    t.datetime "token_expires_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["access_token_hash"], name: "index_users_on_access_token_hash", unique: true
    t.index ["refresh_token_hash"], name: "index_users_on_refresh_token_hash", unique: true
  end

  add_foreign_key "artist_to_schedules", "artists"
  add_foreign_key "artist_to_schedules", "schedules"
  add_foreign_key "schedules", "music_bars"
  add_foreign_key "user_to_schedules", "schedules"
  add_foreign_key "user_to_schedules", "users"
end
