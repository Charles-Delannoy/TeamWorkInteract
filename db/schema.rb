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

ActiveRecord::Schema.define(version: 2021_02_06_153717) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "proposition_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.bigint "group_id", null: false
    t.bigint "survey_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.index ["group_id"], name: "index_campaigns_on_group_id"
    t.index ["survey_id"], name: "index_campaigns_on_survey_id"
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
    t.index ["axe_id"], name: "index_recommandations_on_axe_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.string "icon"
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_type"
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
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "propositions"
  add_foreign_key "answers", "users"
  add_foreign_key "axes", "users"
  add_foreign_key "campaigns", "groups"
  add_foreign_key "campaigns", "surveys"
  add_foreign_key "groups", "users"
  add_foreign_key "propositions", "questions"
  add_foreign_key "questions", "axes"
  add_foreign_key "questions", "surveys"
  add_foreign_key "recommandations", "axes"
  add_foreign_key "surveys", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
