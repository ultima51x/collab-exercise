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

ActiveRecord::Schema[7.1].define(version: 2024_05_09_053920) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "playlist_entries", force: :cascade do |t|
    t.bigint "playlist_id"
    t.bigint "video_id"
    t.integer "seq"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_id", "video_id"], name: "index_playlist_entries_on_playlist_id_and_video_id", unique: true
    t.index ["playlist_id"], name: "index_playlist_entries_on_playlist_id"
    t.index ["video_id"], name: "index_playlist_entries_on_video_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_playlists_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "thumbnail"
    t.string "description"
    t.bigint "views"
    t.string "external_ref"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_ref"], name: "index_videos_on_external_ref", unique: true
  end

  add_foreign_key "playlist_entries", "playlists", on_delete: :cascade
  add_foreign_key "playlist_entries", "videos", on_delete: :cascade
  add_foreign_key "playlists", "users", on_delete: :cascade
end
