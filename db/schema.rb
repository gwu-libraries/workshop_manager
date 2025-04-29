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

ActiveRecord::Schema[8.0].define(version: 2025_04_29_012739) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "application_form_questions", force: :cascade do |t|
    t.bigint "application_form_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_form_id"], name: "index_application_form_questions_on_application_form_id"
    t.index ["question_id"], name: "index_application_form_questions_on_question_id"
  end

  create_table "application_forms", force: :cascade do |t|
    t.bigint "workshop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workshop_id"], name: "index_application_forms_on_workshop_id"
  end

  create_table "facilitators", force: :cascade do |t|
    t.string "name"
    t.boolean "is_admin"
    t.string "profile_url"
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

  create_table "feedback_form_questions", force: :cascade do |t|
    t.bigint "feedback_form_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feedback_form_id"], name: "index_feedback_form_questions_on_feedback_form_id"
    t.index ["question_id"], name: "index_feedback_form_questions_on_question_id"
  end

  create_table "feedback_form_responses", force: :cascade do |t|
    t.bigint "feedback_form_id", null: false
    t.jsonb "response_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feedback_form_id"], name: "index_feedback_form_responses_on_feedback_form_id"
  end

  create_table "feedback_forms", force: :cascade do |t|
    t.bigint "workshop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workshop_id"], name: "index_feedback_forms_on_workshop_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "prompt"
    t.integer "question_format"
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
    t.jsonb "application_responses"
    t.boolean "in_attendance"
    t.integer "application_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_workshop_participants_on_participant_id"
    t.index ["workshop_id"], name: "index_workshop_participants_on_workshop_id"
  end

  create_table "workshops", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "proposal_status", default: 0
    t.integer "attendance_modality"
    t.integer "presentation_modality"
    t.integer "registration_modality"
    t.integer "virtual_attendance_count", default: 0
    t.integer "in_person_attendance_count", default: 0
    t.string "virtual_location"
    t.string "in_person_location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "application_form_questions", "application_forms"
  add_foreign_key "application_form_questions", "questions"
  add_foreign_key "application_forms", "workshops"
  add_foreign_key "feedback_form_questions", "feedback_forms"
  add_foreign_key "feedback_form_questions", "questions"
  add_foreign_key "feedback_form_responses", "feedback_forms"
  add_foreign_key "feedback_forms", "workshops"
  add_foreign_key "track_workshops", "tracks"
  add_foreign_key "track_workshops", "workshops"
  add_foreign_key "workshop_facilitators", "facilitators"
  add_foreign_key "workshop_facilitators", "workshops"
  add_foreign_key "workshop_participants", "participants"
  add_foreign_key "workshop_participants", "workshops"
end
