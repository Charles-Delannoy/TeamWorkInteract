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

ActiveRecord::Schema.define(version: 2021_03_11_085914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "proposition_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "group_campaign_id", null: false
    t.index ["group_campaign_id"], name: "index_answers_on_group_campaign_id"
    t.index ["proposition_id"], name: "index_answers_on_proposition_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "axes", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.string "icon"
    t.index ["user_id"], name: "index_axes_on_user_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.bigint "survey_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.index ["survey_id"], name: "index_campaigns_on_survey_id"
  end

  create_table "chatroom_users", force: :cascade do |t|
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "seen_at"
    t.index ["chatroom_id"], name: "index_chatroom_users_on_chatroom_id"
    t.index ["user_id"], name: "index_chatroom_users_on_user_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "group_campaigns", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "group_id", null: false
    t.bigint "campaign_id", null: false
    t.index ["campaign_id"], name: "index_group_campaigns_on_campaign_id"
    t.index ["group_id"], name: "index_group_campaigns_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "start_date"
    t.date "end_date"
    t.text "description"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "icons", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "family"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "propositions", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "title"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_propositions_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.integer "coef"
    t.bigint "axe_id", null: false
    t.bigint "survey_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["axe_id"], name: "index_questions_on_axe_id"
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "recommandations", force: :cascade do |t|
    t.bigint "axe_id", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.index ["axe_id"], name: "index_recommandations_on_axe_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role"
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "group_campaigns"
  add_foreign_key "answers", "propositions"
  add_foreign_key "answers", "users"
  add_foreign_key "axes", "users"
  add_foreign_key "campaigns", "surveys"
  add_foreign_key "chatroom_users", "chatrooms"
  add_foreign_key "chatroom_users", "users"
  add_foreign_key "group_campaigns", "campaigns"
  add_foreign_key "group_campaigns", "groups"
  add_foreign_key "groups", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "propositions", "questions"
  add_foreign_key "questions", "axes"
  add_foreign_key "questions", "surveys"
  add_foreign_key "recommandations", "axes"
  add_foreign_key "surveys", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
