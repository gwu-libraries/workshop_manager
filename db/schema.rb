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

ActiveRecord::Schema[7.1].define(version: 2024_11_01_162648) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "facilitators", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_facilitators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_facilitators_on_reset_password_token", unique: true
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "track_workshops", force: :cascade do |t|
    t.bigint "track_id", null: false
    t.bigint "workshop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_track_workshops_on_track_id"
    t.index ["workshop_id"], name: "index_track_workshops_on_workshop_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workshop_facilitators", force: :cascade do |t|
    t.bigint "workshop_id", null: false
    t.bigint "facilitator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facilitator_id"], name: "index_workshop_facilitators_on_facilitator_id"
    t.index ["workshop_id"], name: "index_workshop_facilitators_on_workshop_id"
  end

  create_table "workshop_participants", force: :cascade do |t|
    t.bigint "workshop_id", null: false
    t.bigint "participant_id", null: false
    t.boolean "in_attendance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_workshop_participants_on_participant_id"
    t.index ["workshop_id"], name: "index_workshop_participants_on_workshop_id"
  end

  create_table "workshops", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "location"
    t.integer "attendance_strategy"
    t.integer "attendance_count"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "track_workshops", "tracks"
  add_foreign_key "track_workshops", "workshops"
  add_foreign_key "workshop_facilitators", "facilitators"
  add_foreign_key "workshop_facilitators", "workshops"
  add_foreign_key "workshop_participants", "participants"
  add_foreign_key "workshop_participants", "workshops"
end
