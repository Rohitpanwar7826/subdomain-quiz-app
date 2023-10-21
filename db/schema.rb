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

ActiveRecord::Schema[7.0].define(version: 2023_10_10_174955) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.string "title"
    t.string "default_locale"
    t.string "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "plan_id", null: false
    t.uuid "admin_user_id", null: false
    t.index ["admin_user_id"], name: "index_accounts_on_admin_user_id"
    t.index ["plan_id"], name: "index_accounts_on_plan_id"
  end

  create_table "admin_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "plans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "price"
    t.string "no_students"
    t.string "per_month"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_unlimited", default: false
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.uuid "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "subdomain_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "question"
    t.json "options"
    t.string "correct"
    t.uuid "subdomain_quiz_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weight"
    t.index ["subdomain_quiz_id"], name: "index_subdomain_questions_on_subdomain_quiz_id"
  end

  create_table "subdomain_quiz_enrollments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "subdomain_user_id", null: false
    t.uuid "subdomain_quiz_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["subdomain_quiz_id"], name: "index_subdomain_quiz_enrollments_on_subdomain_quiz_id"
    t.index ["subdomain_user_id"], name: "index_subdomain_quiz_enrollments_on_subdomain_user_id"
  end

  create_table "subdomain_quizzes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.integer "total_questions"
    t.integer "duration"
    t.integer "year"
    t.integer "branch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "subdomain_user_id", null: false
    t.boolean "is_published", default: false
    t.datetime "test_date_time"
    t.integer "status", default: 0
    t.string "jid"
    t.index ["subdomain_user_id"], name: "index_subdomain_quizzes_on_subdomain_user_id"
  end

  create_table "subdomain_reports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "subdomain_quiz_id", null: false
    t.uuid "subdomain_question_id", null: false
    t.uuid "subdomain_user_id", null: false
    t.string "weight"
    t.json "result"
    t.boolean "is_correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain_question_id"], name: "index_subdomain_reports_on_subdomain_question_id"
    t.index ["subdomain_quiz_id"], name: "index_subdomain_reports_on_subdomain_quiz_id"
    t.index ["subdomain_user_id"], name: "index_subdomain_reports_on_subdomain_user_id"
  end

  create_table "subdomain_results", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "subdomain_quiz_id", null: false
    t.uuid "subdomain_user_id", null: false
    t.uuid "subdomain_quiz_enrollment_id", null: false
    t.integer "total"
    t.integer "out_of"
    t.integer "pass_or_fail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain_quiz_enrollment_id"], name: "index_subdomain_results_on_subdomain_quiz_enrollment_id"
    t.index ["subdomain_quiz_id"], name: "index_subdomain_results_on_subdomain_quiz_id"
    t.index ["subdomain_user_id"], name: "index_subdomain_results_on_subdomain_user_id"
  end

  create_table "subdomain_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.string "i_card_no_or_roll_no"
    t.integer "branch"
    t.integer "year"
    t.string "github_url"
    t.string "linked_in_url"
    t.boolean "is_valid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_subdomain_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_subdomain_users_on_reset_password_token", unique: true
  end

  create_table "subdomain_users_roles", id: false, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "role_id"
    t.index ["role_id"], name: "index_subdomain_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_subdomain_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_subdomain_users_roles_on_user_id"
  end

  add_foreign_key "accounts", "admin_users"
  add_foreign_key "accounts", "plans"
  add_foreign_key "subdomain_questions", "subdomain_quizzes"
  add_foreign_key "subdomain_quiz_enrollments", "subdomain_quizzes"
  add_foreign_key "subdomain_quiz_enrollments", "subdomain_users"
  add_foreign_key "subdomain_quizzes", "subdomain_users"
  add_foreign_key "subdomain_reports", "subdomain_questions"
  add_foreign_key "subdomain_reports", "subdomain_quizzes"
  add_foreign_key "subdomain_reports", "subdomain_users"
  add_foreign_key "subdomain_results", "subdomain_quiz_enrollments"
  add_foreign_key "subdomain_results", "subdomain_quizzes"
  add_foreign_key "subdomain_results", "subdomain_users"
end
