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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130502033800) do

  create_table "asset_allocations", :force => true do |t|
    t.integer  "asset_id"
    t.integer  "management_department_id"
    t.integer  "cost_center_id"
    t.integer  "construction_period_id"
    t.integer  "specific_investment_id"
    t.decimal  "quantity"
    t.boolean  "enabled"
    t.datetime "enabled_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "asset_cost_adjustments", :force => true do |t|
    t.integer  "asset_id"
    t.date     "effective_date"
    t.decimal  "original_cost_from"
    t.decimal  "original_cost_to"
    t.decimal  "salvage_from"
    t.decimal  "salvage_to"
    t.decimal  "salvage_rate_from"
    t.decimal  "salvage_rate_to"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "confirmed_by_id"
    t.datetime "confirmed_at"
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.integer  "rejected_by_id"
    t.datetime "rejected_at"
    t.boolean  "published"
    t.datetime "published_at"
    t.integer  "submitted_by_id"
    t.datetime "submitted_at"
    t.string   "document_status"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "asset_info_adjustments", :force => true do |t|
    t.integer  "asset_id"
    t.date     "effective_date"
    t.string   "asset_name_from"
    t.string   "asset_name_to"
    t.string   "brand_from"
    t.string   "brand_to"
    t.string   "model_from"
    t.string   "model_to"
    t.string   "serial_no_from"
    t.string   "serial_no_to"
    t.boolean  "is_tariff_free_from"
    t.boolean  "is_tariff_free_to"
    t.boolean  "is_specific_fund_from"
    t.boolean  "is_specific_fund_to"
    t.integer  "tax_preference_id_from"
    t.integer  "tax_preference_id_to"
    t.boolean  "is_vat_free_from"
    t.boolean  "is_vat_free_to"
    t.decimal  "vat_from"
    t.decimal  "vat_to"
    t.decimal  "vat_rate_from"
    t.decimal  "vat_rate_to"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "confirmed_by_id"
    t.datetime "confirmed_at"
    t.datetime "approved_at"
    t.integer  "approved_by_id"
    t.datetime "rejected_at"
    t.integer  "rejected_by_id"
    t.datetime "submitted_at"
    t.integer  "submitted_by_id"
    t.string   "document_status"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "asset_transfer_items", :force => true do |t|
    t.string   "type"
    t.integer  "transfering_asset_id"
    t.integer  "asset_allocation_id"
    t.integer  "management_department_id"
    t.integer  "cost_center_id"
    t.integer  "construction_period_id"
    t.integer  "specific_investment_id"
    t.decimal  "quantity"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "asset_transfer_items", ["type"], :name => "trans_items_type"

  create_table "asset_transfers", :force => true do |t|
    t.integer  "asset_id"
    t.date     "effective_date"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "confirmed_by_id"
    t.datetime "confirmed_at"
    t.datetime "approved_at"
    t.integer  "approved_by_id"
    t.datetime "rejected_at"
    t.integer  "rejected_by_id"
    t.integer  "submitted_by_id"
    t.integer  "submitted_at"
    t.boolean  "published"
    t.datetime "published_at"
    t.string   "document_status"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "assets", :force => true do |t|
    t.string   "asset_no"
    t.string   "asset_name"
    t.string   "brand"
    t.string   "model"
    t.string   "serial_no"
    t.integer  "category_id"
    t.integer  "sub_category_id"
    t.decimal  "original_cost"
    t.decimal  "salvage"
    t.decimal  "salvage_rate"
    t.integer  "activated_by_id"
    t.datetime "activated_at"
    t.boolean  "activated"
    t.integer  "accepted_by_id"
    t.boolean  "accepted"
    t.datetime "accepted_at"
    t.boolean  "is_tariff_free"
    t.boolean  "is_specific_fund"
    t.integer  "tax_preference_id"
    t.boolean  "is_vat_free"
    t.decimal  "vat"
    t.decimal  "vat_rate"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "published"
    t.datetime "published_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "master_data", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.integer  "parent_id"
    t.string   "type"
    t.boolean  "enabled"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "model_relationships", :force => true do |t|
    t.integer  "refer_id_from"
    t.integer  "refer_id_to"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
