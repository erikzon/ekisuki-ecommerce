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

ActiveRecord::Schema[7.0].define(version: 2023_06_01_221916) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :bigint, default: nil, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "record_type", limit: 255, null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "public_active_storage_attachments_blob_id1_idx"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "public_active_storage_attachments_record_type0_idx", unique: true
  end

  create_table "active_storage_blobs", id: :bigint, default: nil, force: :cascade do |t|
    t.string "key", limit: 255, null: false
    t.string "filename", limit: 255, null: false
    t.string "content_type", limit: 255
    t.text "metadata"
    t.string "service_name", limit: 255, null: false
    t.bigint "byte_size", null: false
    t.string "checksum", limit: 255
    t.datetime "created_at", null: false
    t.index ["key"], name: "public_active_storage_blobs_key0_idx", unique: true
  end

  create_table "active_storage_variant_records", id: :bigint, default: nil, force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", limit: 255, null: false
    t.index ["blob_id", "variation_digest"], name: "public_active_storage_variant_records_blob_id0_idx", unique: true
  end

  create_table "carts", id: :bigint, default: nil, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.bigint "order_id"
    t.string "size"
    t.index ["order_id"], name: "public_carts_order_id3_idx"
    t.index ["product_id"], name: "public_carts_product_id2_idx"
    t.index ["user_id"], name: "public_carts_user_id1_idx"
  end

  create_table "categories", id: :bigint, default: nil, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "isClothes", default: false
  end

  create_table "orders", id: :bigint, default: nil, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "shipping_address", limit: 255
    t.string "phone_number", limit: 255
    t.string "email", limit: 255
    t.string "name", limit: 255
    t.integer "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "note"
    t.index ["user_id"], name: "public_orders_user_id0_idx"
  end

  create_table "products", id: :bigint, default: nil, force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.text "description"
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "public_products_category_id0_idx"
  end

  create_table "taggings", id: :bigint, default: nil, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "public_taggings_product_id1_idx"
    t.index ["tag_id"], name: "public_taggings_tag_id0_idx"
  end

  create_table "tags", id: :bigint, default: nil, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :bigint, default: nil, force: :cascade do |t|
    t.string "email", limit: 255, null: false
    t.string "username", limit: 255, null: false
    t.string "password_digest", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin", limit: 2, default: 0
    t.index ["email"], name: "public_users_email0_idx", unique: true
    t.index ["username"], name: "public_users_username1_idx", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id", name: "active_storage_attachments_blob_id_fkey"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id", name: "active_storage_variant_records_blob_id_fkey"
  add_foreign_key "carts", "orders", name: "carts_order_id_fkey"
  add_foreign_key "carts", "products", name: "carts_product_id_fkey"
  add_foreign_key "carts", "users", name: "carts_user_id_fkey"
  add_foreign_key "orders", "users", name: "orders_user_id_fkey"
  add_foreign_key "products", "categories", name: "products_category_id_fkey"
  add_foreign_key "taggings", "products", name: "taggings_product_id_fkey"
  add_foreign_key "taggings", "tags", name: "taggings_tag_id_fkey"
end
