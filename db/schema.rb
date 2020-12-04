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

ActiveRecord::Schema.define(version: 2020_11_08_083213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "m_flags", id: false, force: :cascade do |t|
    t.string "flag_id", limit: 10, null: false
    t.string "flag_value", limit: 30
    t.uuid "user_system_uuid"
  end

  create_table "m_user", primary_key: "user_system_uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.string "user_id", limit: 10, null: false
    t.string "user_name", limit: 40, null: false
    t.string "user_email_address", limit: 20, null: false
    t.string "user_password_encrypted", null: false
    t.index ["user_id"], name: "m_user_un", unique: true
  end

  create_table "t_task_group_linking", primary_key: ["group_uuid", "task_uuid"], comment: "タスクグループ参加テーブル", force: :cascade do |t|
    t.uuid "task_uuid", null: false
    t.uuid "group_uuid", null: false
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.string "created_user_uuid", null: false
  end

  create_table "t_task_plan_headers", primary_key: "task_uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.string "title"
    t.text "memo"
    t.decimal "order_num"
    t.datetime "plan_start_date"
    t.datetime "plan_end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "created_user_uuid", null: false
  end

  create_table "t_task_plan_lists", primary_key: ["task_uuid", "task_sub_uuid"], force: :cascade do |t|
    t.uuid "task_uuid", null: false
    t.string "task_sub_uuid", null: false
    t.decimal "hierarkey_num"
    t.string "seq_num"
    t.string "title"
    t.text "task_memo"
    t.datetime "plan_start_date"
    t.datetime "plan_end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "created_user_uuid", null: false
  end

  create_table "t_task_user_linking", primary_key: ["task_uuid", "user_system_uuid"], comment: "ユーザ参加者テーブル", force: :cascade do |t|
    t.uuid "user_system_uuid", null: false, comment: "ユーザシステムUID"
    t.uuid "task_uuid", null: false, comment: "タスクUID"
    t.integer "authority", default: 1, null: false, comment: "ユーザ閲覧権限"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
  end

end
