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

  create_table "t_task_plan_headers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", comment: "タスクタイトル"
    t.text "memo", comment: "メモ"
    t.decimal "order_num", comment: "処理順序"
    t.datetime "plan_start_date", null: false, comment: "予定開始日"
    t.datetime "plan_end_date", null: false, comment: "予定終了日"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "created_user_uuid", null: false
  end

  create_table "t_task_plan_lists", primary_key: ["t_task_plan_header_id", "id"], comment: "タスク予定内容テーブル", force: :cascade do |t|
    t.uuid "t_task_plan_header_id", null: false, comment: "タスクヘッダUUID"
    t.uuid "id", null: false, comment: "タスク内容UUID"
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

  create_table "t_task_user_linking", primary_key: ["task_uuid", "user_system_uuid"], comment: "ユーザ参加者テーブル", force: :cascade do |t|
    t.uuid "user_system_uuid", null: false, comment: "ユーザシステムUID"
    t.uuid "task_uuid", null: false, comment: "タスクUID"
    t.integer "authority", default: 1, null: false, comment: "ユーザ閲覧権限"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
  end


  create_view "task_lists", sql_definition: <<-SQL
      SELECT task_headers.id,
      plan_list.id AS plan_list_id,
      task_headers.title,
      plan_list.title AS content_title,
      task_headers.order_num AS head_order_num,
      plan_list.hierarkey_num,
      plan_list.seq_num AS plan_order_num,
      task_headers.memo AS content_memo,
      task_headers.plan_start_date AS head_plan_start_date,
      task_headers.plan_end_date AS head_plan_end_date,
      task_headers.plan_start_date AS list_plan_start_date,
      task_headers.plan_end_date AS list_plan_end_date
     FROM (t_task_plan_headers task_headers
       JOIN ( SELECT t_task_plan_lists.t_task_plan_header_id,
              t_task_plan_lists.id,
              t_task_plan_lists.hierarkey_num,
              t_task_plan_lists.seq_num,
              t_task_plan_lists.title,
              t_task_plan_lists.task_memo,
              t_task_plan_lists.plan_start_date,
              t_task_plan_lists.plan_end_date,
              t_task_plan_lists.created_at,
              t_task_plan_lists.updated_at,
              t_task_plan_lists.created_user_uuid
             FROM t_task_plan_lists
            ORDER BY t_task_plan_lists.id, t_task_plan_lists.seq_num) plan_list ON ((task_headers.id = plan_list.t_task_plan_header_id)))
    ORDER BY task_headers.order_num, plan_list.seq_num;
  SQL
end
