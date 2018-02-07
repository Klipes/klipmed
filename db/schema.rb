# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20180207114912) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "companies", force: :cascade do |t|
    t.string "company_name",            null: false
    t.string "trade_name",              null: false
    t.string "address1",                null: false
    t.string "address2"
    t.string "number",       limit: 10
    t.string "neighborhood"
    t.string "city"
    t.string "state",        limit: 2
    t.string "zip",          limit: 10, null: false
    t.string "email"
    t.string "phone"
  end

  create_table "covenants", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "description", limit: 50, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "covenants", ["company_id"], name: "index_covenants_on_company_id"

  create_table "customer_addresses", force: :cascade do |t|
    t.string   "address1",                null: false
    t.string   "address2"
    t.string   "number",       limit: 10
    t.string   "neighborhood"
    t.string   "city"
    t.string   "state",        limit: 2
    t.string   "zip",          limit: 10, null: false
    t.integer  "customer_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "customer_addresses", ["customer_id"], name: "index_customer_addresses_on_customer_id"

  create_table "customers", force: :cascade do |t|
    t.string   "fullname",              null: false
    t.string   "email"
    t.string   "phone",      limit: 20, null: false
    t.integer  "company_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "customers", ["company_id"], name: "index_customers_on_company_id"

  create_table "payable_categories", force: :cascade do |t|
    t.text     "description", limit: 50, null: false
    t.integer  "company_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "payable_categories", ["company_id"], name: "index_payable_categories_on_company_id"

  create_table "payables", force: :cascade do |t|
    t.integer "company_id"
    t.integer "supplier_id"
    t.integer "payable_category_id"
    t.date    "due_date"
    t.integer "amount_cents"
    t.string  "description",         limit: 50,             null: false
    t.integer "status",                         default: 0, null: false
  end

  add_index "payables", ["company_id"], name: "index_payables_on_company_id"
  add_index "payables", ["payable_category_id"], name: "index_payables_on_payable_category_id"
  add_index "payables", ["supplier_id"], name: "index_payables_on_supplier_id"

  create_table "professional_reservations", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "start"
    t.datetime "end"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "professional_reservations", ["company_id"], name: "index_professional_reservations_on_company_id"
  add_index "professional_reservations", ["user_id"], name: "index_professional_reservations_on_user_id"

  create_table "receivable_categories", force: :cascade do |t|
    t.text     "description", limit: 50, null: false
    t.integer  "company_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "receivable_categories", ["company_id"], name: "index_receivable_categories_on_company_id"

  create_table "receivables", force: :cascade do |t|
    t.integer "company_id"
    t.integer "customer_id"
    t.integer "receivable_category_id"
    t.date    "due_date"
    t.integer "amount_cents"
    t.string  "description",            limit: 50,             null: false
    t.integer "status",                            default: 0, null: false
  end

  add_index "receivables", ["company_id"], name: "index_receivables_on_company_id"
  add_index "receivables", ["customer_id"], name: "index_receivables_on_customer_id"
  add_index "receivables", ["receivable_category_id"], name: "index_receivables_on_receivable_category_id"

  create_table "schedules", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "customer_id"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "start"
    t.datetime "end"
    t.integer  "editable",                      default: 1
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "covenant_id"
    t.integer  "schedule_type",                 default: 1
    t.string   "new_customer_phone", limit: 20
    t.string   "new_customer_name"
  end

  add_index "schedules", ["company_id"], name: "index_schedules_on_company_id"
  add_index "schedules", ["covenant_id"], name: "index_schedules_on_covenant_id"
  add_index "schedules", ["customer_id"], name: "index_schedules_on_customer_id"
  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id"

  create_table "supplier_addresses", force: :cascade do |t|
    t.string   "address1",                null: false
    t.string   "address2"
    t.string   "number",       limit: 10
    t.string   "neighborhood"
    t.string   "city"
    t.string   "state",        limit: 2
    t.string   "zip",          limit: 10, null: false
    t.integer  "supplier_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "supplier_addresses", ["supplier_id"], name: "index_supplier_addresses_on_supplier_id"

  create_table "suppliers", force: :cascade do |t|
    t.string   "supplier_name",            null: false
    t.string   "trade_name"
    t.string   "email"
    t.string   "phone",         limit: 20, null: false
    t.integer  "company_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "suppliers", ["company_id"], name: "index_suppliers_on_company_id"

  create_table "user_addresses", force: :cascade do |t|
    t.string   "address1",                null: false
    t.string   "address2"
    t.string   "number",       limit: 10
    t.string   "neighborhood"
    t.string   "city"
    t.string   "state",        limit: 2
    t.string   "zip",          limit: 10, null: false
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "user_addresses", ["user_id"], name: "index_user_addresses_on_user_id"

  create_table "user_covenants", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "covenant_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_covenants", ["covenant_id"], name: "index_user_covenants_on_covenant_id"
  add_index "user_covenants", ["user_id"], name: "index_user_covenants_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "name"
    t.integer  "company_id"
    t.integer  "role",                   default: 0,  null: false
    t.integer  "user_type",              default: 0,  null: false
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
