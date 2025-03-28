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

ActiveRecord::Schema[8.0].define(version: 2025_03_27_153846) do
  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_categories_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "resource_type", default: "course", null: false
    t.string "progress_status", default: "unstarted", null: false
    t.string "link", null: false
    t.boolean "owned", default: true, null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["progress_status"], name: "index_resources_on_progress_status"
    t.index ["resource_type"], name: "index_resources_on_resource_type"
    t.index ["user_id", "name"], name: "index_resources_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_resources_on_user_id"
    t.check_constraint "progress_status in ('unstarted', 'in_progress', 'completed', 'abandoned')", name: "progress_status_check"
    t.check_constraint "resource_type in ('course', 'book', 'video', 'article', 'podcast', 'other')", name: "resource_type_check"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "categories", "users"
  add_foreign_key "resources", "users"
  add_foreign_key "sessions", "users"
end
