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

ActiveRecord::Schema.define(version: 20161024061121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "executables", force: :cascade do |t|
    t.integer  "project_id",               null: false
    t.string   "name",                     null: false
    t.string   "version"
    t.integer  "phase",        default: 0, null: false
    t.integer  "kind",                     null: false
    t.string   "node_version"
    t.string   "file"
    t.integer  "file_size"
    t.datetime "done_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "project_users", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "latest_version", null: false
    t.json     "npm_payload",    null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "login",                            null: false
    t.string   "name",                             null: false
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "github_uid",                       null: false
    t.string   "github_access_token",              null: false
    t.json     "github_payload",                   null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["github_uid"], name: "index_users_on_github_uid", unique: true, using: :btree
  end

end
