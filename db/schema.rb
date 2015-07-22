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

ActiveRecord::Schema.define(version: 20150722170936) do

  create_table "candidate_subscribes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consults", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "title"
    t.text     "content"
    t.boolean  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "consults", ["project_id"], name: "index_consults_on_project_id"

  create_table "navs", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "page_id"
    t.string   "title"
    t.integer  "nav_type"
    t.string   "url"
    t.integer  "target"
    t.integer  "order",      default: 0
    t.boolean  "publish"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "navs", ["page_id"], name: "index_navs_on_page_id"
  add_index "navs", ["project_id"], name: "index_navs_on_project_id"

  create_table "pages", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.boolean  "publish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pages", ["project_id"], name: "index_pages_on_project_id"

  create_table "project_participations", force: :cascade do |t|
    t.string   "title"
    t.integer  "project_id"
    t.integer  "project_subscribe_id"
    t.date     "start"
    t.date     "end"
    t.string   "form_code"
    t.boolean  "publish"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "project_participations", ["project_id"], name: "index_project_participations_on_project_id"
  add_index "project_participations", ["project_subscribe_id"], name: "index_project_participations_on_project_subscribe_id"

  create_table "project_subscribes", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "title"
    t.text     "description"
    t.date     "start"
    t.date     "end"
    t.boolean  "fee"
    t.float    "fee_value"
    t.string   "form_code"
    t.boolean  "publish"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "project_subscribes", ["project_id"], name: "index_project_subscribes_on_project_id"

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.date     "start"
    t.date     "end"
    t.boolean  "publish"
    t.boolean  "status"
    t.string   "image_header"
    t.string   "image_logo"
    t.string   "image_footer"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "privilege",              default: 0
    t.boolean  "administrator",          default: false
    t.string   "name"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
