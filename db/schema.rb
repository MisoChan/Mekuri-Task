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

  create_table "m_task_flags", id: false, force: :cascade do |t|
    t.string "flag_id", limit: 10, null: false
    t.string "flag_value", limit: 30
    t.uuid "user_system_uuid", default: -> { "gen_random_uuid()" }
  end

  create_table "m_users", primary_key: "user_system_uuid", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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

  create_table "t_task_head_plan_linking", id: false, force: :cascade do |t|
    t.uuid "t_task_plan_headers_id", null: false
    t.uuid "t_task_plan_lists_id", null: false
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.string "created_user_uuid", null: false
  end

  create_table "t_task_plan_headers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", comment: "タスクタイトル"
    t.text "memo", comment: "メモ"
    t.decimal "order_num", comment: "処理順序"
    t.datetime "plan_start_date", null: false, comment: "予定開始日"
    t.datetime "plan_end_date", null: false, comment: "予定終了日"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "created_user_uuid", null: false
    t.string "task_memo", limit: 800
  end

  create_table "t_task_plan_lists", id: :uuid, default: nil, comment: "タスク予定内容テーブル", force: :cascade do |t|
    t.decimal "hierarkey_num", comment: "階層番号"
    t.string "seq_num", comment: "タスク処理順番号"
    t.string "title", comment: "タイトル"
    t.text "task_memo", comment: "メモ"
    t.datetime "plan_start_date", null: false, comment: "予定開始日時"
    t.datetime "plan_end_date", null: false, comment: "予定終了日時"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "created_user_uuid", null: false, comment: "作成ユーザID"
  end

  create_table "t_task_records", id: :uuid, default: nil, comment: "タスク実績テーブル", force: :cascade do |t|
    t.date "record_time", null: false, comment: "記録時間"
    t.datetime "created_at", null: false, comment: "作成時間"
    t.datetime "updated_at", null: false, comment: "更新日時"
    t.uuid "created_user_uuid", null: false, comment: "作成ユーザID"
    t.datetime "start_time", precision: 0, comment: "実記録開始時間"
    t.datetime "end_time", precision: 0, comment: "実記録終了時間"
    t.string "task_head_title", comment: "タスクヘッダタイトル"
    t.uuid "t_task_head_id", null: false, comment: "タスクヘッダUUID"
    t.string "task_plan_title", comment: "タスクヘッダタイトル"
    t.string "t_task_plan_memo", comment: "タスク内容メモ"
    t.uuid "task_plan_uuid", null: false, comment: "タスク内容UUID"
  end

  create_table "t_task_user_linking", primary_key: ["task_uuid", "user_system_uuid"], comment: "ユーザ参加者テーブル", force: :cascade do |t|
    t.uuid "user_system_uuid", null: false, comment: "ユーザシステムUID"
    t.uuid "task_uuid", null: false, comment: "タスクUID"
    t.integer "authority", default: 1, null: false, comment: "ユーザ閲覧権限"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
  end

  add_foreign_key "t_task_head_plan_linking", "t_task_plan_headers", column: "t_task_plan_headers_id", name: "t_task_head_plan_linking_fk", on_delete: :cascade
  add_foreign_key "t_task_head_plan_linking", "t_task_plan_lists", column: "t_task_plan_lists_id", name: "t_task_head_plan_linking_fk_1"
  add_foreign_key "t_task_records", "t_task_plan_lists", column: "id", name: "t_task_records_fk", on_delete: :cascade

  create_view "task_plan_lists", sql_definition: <<-SQL
      SELECT t_task_head_plan_linking.t_task_plan_lists_id AS id,
      t_task_head_plan_linking.t_task_plan_headers_id AS t_task_plan_header_id,
      t_task_plan_lists.hierarkey_num,
      t_task_plan_lists.seq_num,
      t_task_plan_lists.title,
      t_task_plan_lists.task_memo,
      t_task_plan_lists.plan_start_date,
      t_task_plan_lists.plan_end_date
     FROM (t_task_head_plan_linking
       JOIN t_task_plan_lists ON ((t_task_plan_lists.id = t_task_head_plan_linking.t_task_plan_lists_id)))
    ORDER BY t_task_head_plan_linking.t_task_plan_headers_id, t_task_plan_lists.seq_num;
  SQL
end
