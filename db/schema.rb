# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_02_070944) do

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

  create_table "analytics", force: :cascade do |t|
    t.bigint "site_id"
    t.string "search_string"
    t.float "search_reponse_time"
    t.float "text_processing_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_analytics_on_site_id"
  end

  create_table "custom_responses", force: :cascade do |t|
    t.bigint "site_id"
    t.string "searched_text"
    t.string "target_url"
    t.integer "search_ranking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_custom_responses_on_site_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "plan_name"
    t.integer "query_limit"
    t.float "price"
    t.string "duration_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "site_configurations", force: :cascade do |t|
    t.bigint "site_id"
    t.boolean "return_results_on_rendered_page"
    t.boolean "return_results_on_customer_webpage"
    t.string "custom_search_results_url"
    t.string "search_icon_color"
    t.string "search_icon_text"
    t.string "search_box_size"
    t.string "search_box_shape"
    t.string "search_box_fill_color"
    t.string "search_box_border_color"
    t.string "search_box_placeholder_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_site_configurations_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "site_name"
    t.string "site_url"
    t.string "company_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_sites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "client_key"
    t.string "client_secret"
    t.string "contact_number"
    t.string "status", default: "inactive"
    t.bigint "plan_id", default: 1
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["plan_id"], name: "index_users_on_plan_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.bigint "site_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["site_id"], name: "index_users_roles_on_site_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "users_sites", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "site_id"
    t.index ["site_id"], name: "index_users_sites_on_site_id"
    t.index ["user_id", "site_id"], name: "index_users_sites_on_user_id_and_site_id"
    t.index ["user_id"], name: "index_users_sites_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "analytics", "sites"
  add_foreign_key "custom_responses", "sites"
  add_foreign_key "site_configurations", "sites"
  add_foreign_key "users", "plans"
end
