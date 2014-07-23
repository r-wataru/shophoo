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

ActiveRecord::Schema.define(version: 20140723134446) do

  create_table "accounts", force: true do |t|
    t.string   "type",            null: false
    t.string   "screen_name",     null: false
    t.string   "real_name"
    t.string   "family_name"
    t.string   "given_name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["screen_name"], name: "index_accounts_on_screen_name", unique: true, using: :btree

  create_table "administrators", force: true do |t|
    t.string   "login_name",                      null: false
    t.string   "password_digest",                 null: false
    t.boolean  "super_user",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "address",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emails", ["address"], name: "index_emails_on_address", unique: true, using: :btree

  create_table "items", force: true do |t|
    t.integer  "organization_id"
    t.string   "code_name",       null: false
    t.string   "display_name",    null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["organization_id"], name: "index_items_on_organization_id", using: :btree

  create_table "manager_roles", force: true do |t|
    t.integer  "user_id",                         null: false
    t.integer  "organization_id",                 null: false
    t.boolean  "owner",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "manager_roles", ["user_id", "organization_id"], name: "index_manager_roles_on_user_id_and_organization_id", unique: true, using: :btree

  create_table "new_emails", force: true do |t|
    t.integer  "user_id",                            null: false
    t.string   "address",                            null: false
    t.string   "confirmation_token",                 null: false
    t.boolean  "used",               default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopping_carts", force: true do |t|
    t.integer  "user_id",    null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
