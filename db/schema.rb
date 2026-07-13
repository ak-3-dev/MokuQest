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

ActiveRecord::Schema[8.0].define(version: 2026_07_11_065316) do
  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "ai_plans", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "goal"
    t.string "period"
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "plan_date"
    t.integer "quest_id"
    t.integer "current_day", default: 1
    t.date "started_on"
    t.index ["quest_id"], name: "index_ai_plans_on_quest_id"
    t.index ["user_id"], name: "index_ai_plans_on_user_id"
  end

  create_table "ai_tasks", force: :cascade do |t|
    t.integer "ai_plan_id", null: false
    t.string "title"
    t.text "description"
    t.integer "exp"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "day"
    t.index ["ai_plan_id"], name: "index_ai_tasks_on_ai_plan_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.integer "user_id", null: false
    t.integer "quest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id"], name: "index_comments_on_quest_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "group_requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_requests_on_group_id"
    t.index ["user_id"], name: "index_group_requests_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "rules"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "quests", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "status"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "goal"
    t.string "period"
    t.text "motivation"
    t.string "level"
    t.date "due_date"
  end

  create_table "user_quests", force: :cascade do |t|
    t.string "goal"
    t.string "period"
    t.text "motivation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "level"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "exp", default: 0, null: false
    t.integer "level", default: 1, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ai_plans", "quests"
  add_foreign_key "ai_plans", "users"
  add_foreign_key "ai_tasks", "ai_plans"
  add_foreign_key "comments", "quests"
  add_foreign_key "comments", "users"
  add_foreign_key "group_requests", "groups"
  add_foreign_key "group_requests", "users"
  add_foreign_key "groups", "users"
end
