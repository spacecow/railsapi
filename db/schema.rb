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

ActiveRecord::Schema.define(version: 20151229023626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "article_mentions", force: :cascade do |t|
    t.integer "origin_id", null: false
    t.integer "target_id", null: false
    t.string  "content"
  end

  add_index "article_mentions", ["origin_id", "target_id"], name: "index_article_mentions_on_origin_id_and_target_id", unique: true, using: :btree

  create_table "article_notes", force: :cascade do |t|
    t.integer  "article_id", null: false
    t.integer  "note_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "article_notes", ["note_id"], name: "index_article_notes_on_note_id", unique: true, using: :btree

  create_table "article_tags", force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "tag_id",     null: false
  end

  add_index "article_tags", ["article_id", "tag_id"], name: "index_article_tags_on_article_id_and_tag_id", unique: true, using: :btree

  create_table "articles", force: :cascade do |t|
    t.string  "name",                                null: false
    t.integer "universe_id",                         null: false
    t.string  "type",                                null: false
    t.string  "gender",      limit: 1, default: "n"
  end

  create_table "books", force: :cascade do |t|
    t.string  "title",       null: false
    t.integer "universe_id", null: false
  end

  add_index "books", ["title", "universe_id"], name: "index_books_on_title_and_universe_id", unique: true, using: :btree

  create_table "citations", force: :cascade do |t|
    t.integer  "origin_id"
    t.integer  "target_id"
    t.string   "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_notes", force: :cascade do |t|
    t.integer  "event_id",   null: false
    t.integer  "note_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "event_notes", ["note_id"], name: "index_event_notes_on_note_id", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "universe_id", null: false
    t.string   "title",       null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "events", ["title", "universe_id"], name: "index_events_on_title_and_universe_id", unique: true, using: :btree

  create_table "mentions", force: :cascade do |t|
    t.integer "origin_id", null: false
    t.integer "target_id", null: false
  end

  add_index "mentions", ["origin_id", "target_id"], name: "index_mentions_on_origin_id_and_target_id", unique: true, using: :btree

  create_table "note_tags", force: :cascade do |t|
    t.integer "note_id", null: false
    t.integer "tag_id",  null: false
  end

  add_index "note_tags", ["note_id", "tag_id"], name: "index_note_tags_on_note_id_and_tag_id", unique: true, using: :btree

  create_table "notes", force: :cascade do |t|
    t.string "text", null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "participations", force: :cascade do |t|
    t.integer  "event_id",   null: false
    t.integer  "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "participations", ["event_id", "article_id"], name: "index_participations_on_event_id_and_article_id", unique: true, using: :btree

# Could not dump table "references" because of following StandardError
#   Unknown type 'referenceable_type_enum' for column 'referenceable_type'

  create_table "relations", force: :cascade do |t|
    t.integer  "origin_id",  null: false
    t.integer  "target_id",  null: false
    t.string   "type",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "relations", ["origin_id", "target_id"], name: "index_relations_on_origin_id_and_target_id", unique: true, using: :btree

  create_table "spatial_ref_sys", primary_key: "srid", force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

  create_table "steps", force: :cascade do |t|
    t.integer  "parent_id",  null: false
    t.integer  "child_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "steps", ["parent_id", "child_id"], name: "index_steps_on_parent_id_and_child_id", unique: true, using: :btree

# Could not dump table "taggings" because of following StandardError
#   Unknown type 'tagable_type_enum' for column 'tagable_type'

  create_table "tags", force: :cascade do |t|
    t.string "title", null: false
  end

  create_table "universes", force: :cascade do |t|
    t.string "title", null: false
  end

  add_index "universes", ["title"], name: "index_universes_on_title", unique: true, using: :btree

  add_foreign_key "article_mentions", "articles", column: "target_id"
  add_foreign_key "article_mentions", "events", column: "origin_id"
  add_foreign_key "article_notes", "articles"
  add_foreign_key "article_notes", "notes"
  add_foreign_key "article_tags", "articles"
  add_foreign_key "article_tags", "tags"
  add_foreign_key "articles", "universes"
  add_foreign_key "books", "universes"
  add_foreign_key "citations", "articles", column: "origin_id"
  add_foreign_key "citations", "articles", column: "target_id"
  add_foreign_key "event_notes", "events"
  add_foreign_key "event_notes", "notes"
  add_foreign_key "events", "universes"
  add_foreign_key "mentions", "events", column: "origin_id"
  add_foreign_key "mentions", "events", column: "target_id"
  add_foreign_key "note_tags", "notes"
  add_foreign_key "note_tags", "tags"
  add_foreign_key "participations", "articles"
  add_foreign_key "participations", "events"
  add_foreign_key "relations", "articles", column: "origin_id"
  add_foreign_key "relations", "articles", column: "target_id"
  add_foreign_key "steps", "events", column: "child_id"
  add_foreign_key "steps", "events", column: "parent_id"
  add_foreign_key "taggings", "tags"
end
