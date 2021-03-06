# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_29_221404) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_admin_profiles_on_user_id", unique: true
  end

  create_table "authentications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.json "info", default: {}, null: false
    t.json "credentials", default: {}, null: false
    t.json "extra", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider"], name: "index_authentications_on_provider"
    t.index ["user_id", "provider", "uid"], name: "index_authentications_on_user_id_and_provider_and_uid", unique: true
    t.index ["user_id", "provider"], name: "index_authentications_on_user_id_and_provider", unique: true
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "client_invitations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "slug", null: false
    t.integer "status", default: 0, null: false
    t.json "failure", default: {}
    t.uuid "sender_id", null: false
    t.string "sender_type", null: false
    t.uuid "recipient_id", comment: "Recipient is attached when a client profile is created upon acceptance"
    t.string "recipient_type", comment: "Recipient is attached when a client profile is created upon acceptance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_client_invitations_on_email"
    t.index ["recipient_id", "recipient_type"], name: "index_client_invitations_on_recipient_id_and_recipient_type"
    t.index ["sender_id", "sender_type", "email"], name: "index_client_invitations_on_sender_id_and_sender_type_and_email"
    t.index ["sender_id", "sender_type"], name: "index_client_invitations_on_sender_id_and_sender_type"
    t.index ["slug"], name: "index_client_invitations_on_slug"
    t.index ["status"], name: "index_client_invitations_on_status"
  end

  create_table "client_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "pending_client_id", comment: "PendingClient is only required if the user is blank, vice-versa"
    t.index ["pending_client_id"], name: "index_client_profiles_on_pending_client_id"
    t.index ["user_id"], name: "index_client_profiles_on_user_id", unique: true
  end

  create_table "coach_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_coach_profiles_on_user_id", unique: true
  end

  create_table "coaching_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "client_profile_id", null: false
    t.uuid "coach_profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "video_embed", comment: "Not every session will have embedded videos"
    t.string "external_id", null: false
    t.string "external_url", null: false
    t.string "name", null: false
    t.string "external_status", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.datetime "external_created_at", null: false
    t.datetime "external_updated_at", null: false
    t.jsonb "event_type", null: false
    t.jsonb "location", null: false
    t.integer "invitees_counter_total", null: false
    t.integer "invitees_counter_active", null: false
    t.integer "invitees_counter_limit", null: false
    t.index ["client_profile_id"], name: "index_coaching_sessions_on_client_profile_id"
    t.index ["coach_profile_id", "client_profile_id"], name: "coaching_sessions_coach_client"
    t.index ["coach_profile_id"], name: "index_coaching_sessions_on_coach_profile_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.uuid "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "imported_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "coaching_session_id", comment: "A coaching session might not be created for the imported event"
    t.uuid "client_profile_id", null: false
    t.uuid "coach_profile_id", null: false
    t.string "external_id", null: false
    t.string "external_url", null: false
    t.string "name", null: false
    t.string "external_status", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.datetime "external_created_at", null: false
    t.datetime "external_updated_at", null: false
    t.jsonb "event_type", null: false
    t.jsonb "location", null: false
    t.integer "invitees_counter_total", null: false
    t.integer "invitees_counter_active", null: false
    t.integer "invitees_counter_limit", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_profile_id"], name: "index_imported_events_on_client_profile_id"
    t.index ["coach_profile_id"], name: "index_imported_events_on_coach_profile_id"
    t.index ["coaching_session_id"], name: "index_imported_events_on_coaching_session_id"
  end

  create_table "pending_clients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.uuid "client_invitation_id", comment: "Invitations not required"
    t.uuid "coach_profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_invitation_id"], name: "index_pending_clients_on_client_invitation_id"
    t.index ["coach_profile_id"], name: "index_pending_clients_on_coach_profile_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "auth_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.string "foreign_type"
    t.index ["foreign_key_name", "foreign_key_id", "foreign_type"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type"
    t.string "{:null=>false}"
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.integer "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_profiles", "users"
  add_foreign_key "authentications", "users"
  add_foreign_key "client_profiles", "pending_clients"
  add_foreign_key "client_profiles", "users"
  add_foreign_key "coach_profiles", "users"
  add_foreign_key "coaching_sessions", "client_profiles"
  add_foreign_key "coaching_sessions", "coach_profiles"
  add_foreign_key "imported_events", "client_profiles"
  add_foreign_key "imported_events", "coach_profiles"
  add_foreign_key "imported_events", "coaching_sessions"
  add_foreign_key "pending_clients", "client_invitations"
  add_foreign_key "pending_clients", "coach_profiles"
end
