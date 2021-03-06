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

ActiveRecord::Schema.define(version: 20150626000712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attendances", ["event_id"], name: "index_attendances_on_event_id", using: :btree
  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "event_types", force: :cascade do |t|
    t.string   "name"
    t.text     "examples"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_types_events", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "event_type_id"
  end

  add_index "event_types_events", ["event_id"], name: "index_event_types_events_on_event_id", using: :btree
  add_index "event_types_events", ["event_type_id"], name: "index_event_types_events_on_event_type_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "date"
    t.float    "price"
    t.integer  "place_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "events", ["owner_type", "owner_id"], name: "index_events_on_owner_type_and_owner_id", using: :btree
  add_index "events", ["place_id"], name: "index_events_on_place_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "memberships", force: :cascade do |t|
    t.boolean  "is_admin"
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.float    "lat"
    t.float    "lon"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "address"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "places", ["owner_type", "owner_id"], name: "index_places_on_owner_type_and_owner_id", using: :btree

  create_table "places_users", id: false, force: :cascade do |t|
    t.integer "place_id"
    t.integer "user_id"
  end

  add_index "places_users", ["place_id"], name: "index_places_users_on_place_id", using: :btree
  add_index "places_users", ["user_id"], name: "index_places_users_on_user_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "value"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "ratings", ["rateable_type", "rateable_id"], name: "index_ratings_on_rateable_type_and_rateable_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", null: false
    t.integer  "followed_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reportable_id"
    t.string   "reportable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "reports", ["reportable_type", "reportable_id"], name: "index_reports_on_reportable_type_and_reportable_id", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "mail"
    t.string   "phone"
    t.date     "birthday"
    t.boolean  "male"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["mail"], name: "index_users_on_mail", unique: true, using: :btree

  add_foreign_key "attendances", "events"
  add_foreign_key "attendances", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "event_types_events", "event_types"
  add_foreign_key "event_types_events", "events"
  add_foreign_key "events", "places"
  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "users"
  add_foreign_key "places_users", "places"
  add_foreign_key "places_users", "users"
  add_foreign_key "ratings", "users"
  add_foreign_key "relationships", "users", column: "followed_id"
  add_foreign_key "relationships", "users", column: "follower_id"
  add_foreign_key "reports", "users"
end
