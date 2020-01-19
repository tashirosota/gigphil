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

ActiveRecord::Schema.define(version: 2020_01_19_035929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_to_schedules", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "schedule_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id", "schedule_id"], name: "index_artist_to_schedules_on_artist_id_and_schedule_id", unique: true
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

  create_table "time_table_concerts", force: :cascade do |t|
    t.bigint "time_table_id", null: false
    t.integer "order", null: false
    t.string "band_name", null: false
    t.integer "custom_play_time"
    t.integer "custom_setting_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["time_table_id"], name: "index_time_table_concerts_on_time_table_id"
  end

  create_table "time_table_rehearsals", force: :cascade do |t|
    t.bigint "time_table_id", null: false
    t.integer "order", null: false
    t.string "band_name", null: false
    t.integer "custom_play_time"
    t.integer "custom_setting_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["time_table_id"], name: "index_time_table_rehearsals_on_time_table_id"
  end

  create_table "time_tables", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "uuid", null: false
    t.string "title", null: false
    t.string "place"
    t.text "memo"
    t.datetime "event_date", null: false
    t.datetime "meeting_time", null: false
    t.datetime "open_time", null: false
    t.datetime "start_time", null: false
    t.integer "rehearsal_setting_time"
    t.integer "rehearsal_play_time"
    t.integer "production_setting_time"
    t.integer "production_play_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_time_tables_on_user_id"
    t.index ["uuid"], name: "index_time_tables_on_uuid", unique: true
  end

  create_table "user_to_schedules", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "schedule_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["schedule_id"], name: "index_user_to_schedules_on_schedule_id"
    t.index ["user_id", "schedule_id"], name: "index_user_to_schedules_on_user_id_and_schedule_id", unique: true
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
  add_foreign_key "time_table_concerts", "time_tables"
  add_foreign_key "time_table_rehearsals", "time_tables"
  add_foreign_key "time_tables", "users"
  add_foreign_key "user_to_schedules", "schedules"
  add_foreign_key "user_to_schedules", "users"
end
