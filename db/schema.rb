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

ActiveRecord::Schema[7.1].define(version: 2024_03_22_144505) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "nom_complet"
    t.string "adresse"
    t.string "ville"
    t.string "code_postal"
    t.string "num_siret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devis", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "tva", default: "0.0"
    t.integer "status", default: 0
    t.boolean "liquidation_tva", default: false
    t.index ["client_id"], name: "index_devis_on_client_id"
  end

  create_table "factures", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.decimal "tva"
    t.integer "status", default: 0
    t.boolean "liquidation_tva", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_factures_on_client_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "devi_id"
    t.text "detail"
    t.integer "quantite"
    t.string "prix_unitaire_ht", default: "0,0"
    t.integer "total_ht"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unite"
    t.bigint "facture_id"
    t.index ["devi_id"], name: "index_items_on_devi_id"
    t.index ["facture_id"], name: "index_items_on_facture_id"
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
    t.integer "role", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "devis", "clients"
  add_foreign_key "factures", "clients"
  add_foreign_key "items", "devis"
  add_foreign_key "items", "factures"
end
