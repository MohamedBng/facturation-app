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

ActiveRecord::Schema[7.1].define(version: 2024_05_18_085708) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "nom_complet"
    t.string "adresse"
    t.string "ville"
    t.string "code_postal"
    t.string "num_siret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "phone_number"
    t.string "email"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "devis", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "tva", default: "0.0"
    t.integer "status", default: 0
    t.bigint "provider_id", null: false
    t.string "number"
    t.bigint "user_id", null: false
    t.integer "vat_application_type"
    t.text "description"
    t.date "date_of_creation"
    t.date "date_of_validity"
    t.date "start_date_of_service"
    t.string "intervention_location"
    t.integer "estimated_duration"
    t.integer "duration_unit"
    t.boolean "paid", default: false, null: false
    t.integer "payment_method_mask"
    t.integer "simple_payment_method", default: 0
    t.text "payment_terms"
    t.integer "deposit"
    t.integer "global_discount"
    t.integer "global_discount_type"
    t.index ["client_id"], name: "index_devis_on_client_id"
    t.index ["provider_id"], name: "index_devis_on_provider_id"
    t.index ["user_id"], name: "index_devis_on_user_id"
  end

  create_table "factures", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.decimal "tva"
    t.integer "status", default: 0
    t.boolean "liquidation_tva", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "number"
    t.bigint "provider_id", null: false
    t.index ["client_id"], name: "index_factures_on_client_id"
    t.index ["provider_id"], name: "index_factures_on_provider_id"
    t.index ["user_id"], name: "index_factures_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "devi_id"
    t.text "detail"
    t.integer "quantite"
    t.integer "prix_unitaire_ht", default: 0
    t.integer "total_ht"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unite"
    t.bigint "facture_id"
    t.decimal "tva", precision: 5, scale: 2, default: "0.0"
    t.boolean "exempt_tva", default: false
    t.index ["devi_id"], name: "index_items_on_devi_id"
    t.index ["facture_id"], name: "index_items_on_facture_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "postal_code"
    t.string "num_siret"
    t.jsonb "logo_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "starting_quotation_number", default: 1
    t.bigint "user_id", null: false
    t.integer "starting_invoice_number", default: 1
    t.string "primary_color", default: "#009688"
    t.string "secondary_color", default: "#00796B"
    t.string "background_color", default: "#FFFFFF"
    t.string "text_color", default: "#333333"
    t.index ["user_id"], name: "index_providers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lastname"
    t.string "firstname"
    t.integer "role", default: 1, null: false
    t.string "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clients", "users"
  add_foreign_key "devis", "clients"
  add_foreign_key "devis", "providers"
  add_foreign_key "devis", "users"
  add_foreign_key "factures", "clients"
  add_foreign_key "factures", "providers"
  add_foreign_key "factures", "users"
  add_foreign_key "items", "devis"
  add_foreign_key "items", "factures"
  add_foreign_key "providers", "users"
end
