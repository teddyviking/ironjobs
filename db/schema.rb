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

ActiveRecord::Schema.define(version: 20150522141644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "job_applications", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "student_type"
    t.integer  "job_post_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "job_applications", ["job_post_id"], name: "index_job_applications_on_job_post_id", using: :btree
  add_index "job_applications", ["student_id"], name: "index_job_applications_on_student_id", using: :btree

  create_table "job_posts", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "company_type"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "description"
    t.string   "location"
    t.integer  "salary"
    t.string   "contract_type"
    t.string   "position"
    t.boolean  "confirmed",     default: false
  end

  add_index "job_posts", ["company_id"], name: "index_job_posts_on_company_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "location"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "url"
    t.string   "facebook"
    t.string   "github"
    t.string   "twitter"
    t.string   "linkedin"
    t.text     "description"
    t.integer  "phone"
    t.boolean  "searching",              default: false
    t.string   "email",                  default: "",        null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "role",                   default: "company"
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "situation"
    t.string   "company_name"
    t.boolean  "confirmed",              default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
