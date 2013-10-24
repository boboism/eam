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

ActiveRecord::Schema.define(:version => 20131021040350) do

  create_table "accessories", :force => true do |t|
    t.string   "name"
    t.string   "brand"
    t.string   "model"
    t.string   "specification"
    t.string   "serial_no"
    t.string   "store_location"
    t.decimal  "amount"
    t.boolean  "enabled"
    t.integer  "asset_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "accessory_adjustment_items", :force => true do |t|
    t.string   "name"
    t.string   "model"
    t.string   "specification"
    t.string   "serial_no"
    t.string   "brand"
    t.string   "store_location"
    t.decimal  "amount"
    t.string   "type"
    t.integer  "accessory_adjusting_asset_id"
    t.integer  "accessory_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "accessory_adjustments", :force => true do |t|
    t.date     "effective_date",  :default => '2013-10-22'
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "submitted_by_id"
    t.datetime "submitted_at"
    t.boolean  "submitted",       :default => false
    t.boolean  "confirmed",       :default => false
    t.integer  "confirmed_by_id"
    t.datetime "confirmed_at"
    t.boolean  "approved",        :default => false
    t.datetime "approved_at"
    t.integer  "approved_by_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "asset_allocations", :force => true do |t|
    t.integer  "asset_id"
    t.integer  "management_department_id"
    t.integer  "cost_center_id"
    t.integer  "construction_period_id"
    t.integer  "specific_investment_id"
    t.decimal  "allocation_propotion"
    t.boolean  "enabled"
    t.datetime "enabled_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "responsible_by"
    t.integer  "disabled_by_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "asset_allocations", ["asset_id"], :name => "asset_alloc_asset"
  add_index "asset_allocations", ["cost_center_id"], :name => "asset_alloc_ccenter"
  add_index "asset_allocations", ["enabled"], :name => "asset_alloc_enabled"
  add_index "asset_allocations", ["management_department_id"], :name => "asset_alloc_mgmt_dept"

  create_table "asset_categorization_items", :force => true do |t|
    t.integer  "asset_id"
    t.integer  "category_id"
    t.integer  "sub_category_id"
    t.string   "asset_no"
    t.string   "asset_name"
    t.string   "brand"
    t.string   "model"
    t.string   "specification"
    t.string   "serial_no"
    t.string   "purchase_no"
    t.date     "arrival_date"
    t.string   "design_company"
    t.string   "construction_company"
    t.date     "construction_date_from"
    t.date     "construction_date_to"
    t.string   "supplier"
    t.string   "contract_no"
    t.string   "usage"
    t.string   "remark"
    t.integer  "asset_categorization_id"
    t.decimal  "allocation_propotion",     :precision => 18, :scale => 2, :default => 100.0
    t.integer  "cost_center_id"
    t.integer  "management_department_id"
    t.date     "warranty_date_from",                                      :default => '2013-10-22'
    t.date     "warranty_date_to",                                        :default => '2013-10-22'
    t.integer  "warranty_period",                                         :default => 0
    t.integer  "store_location_id"
    t.string   "responsible_by"
    t.decimal  "original_cost",            :precision => 18, :scale => 2, :default => 0.0
    t.decimal  "vat",                      :precision => 18, :scale => 2, :default => 0.0
    t.decimal  "vat_rate",                 :precision => 18, :scale => 2, :default => 17.0
    t.boolean  "is_energy_saving",                                        :default => false
    t.boolean  "is_env_protection",                                       :default => false
    t.boolean  "is_research_use",                                         :default => false
    t.boolean  "is_safety_production",                                    :default => false
    t.boolean  "is_not_any_favorable",                                    :default => false
    t.boolean  "is_vat_deduction",                                        :default => false
    t.boolean  "is_specific_fund",                                        :default => false
    t.boolean  "is_tariff_free",                                          :default => false
    t.integer  "construction_period_id"
    t.integer  "specific_investment_id"
    t.integer  "accessory_status"
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
  end

  create_table "asset_categorizations", :force => true do |t|
    t.integer  "categorize_type",       :default => 128
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "submitted",             :default => false
    t.integer  "submitted_by_id"
    t.datetime "submitted_at"
    t.boolean  "confirmed",             :default => false
    t.integer  "confirmed_by_id"
    t.datetime "confirmed_at"
    t.boolean  "approved",              :default => false
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.boolean  "number_arranged",       :default => false
    t.integer  "number_arranged_by_id"
    t.datetime "number_arranged_at"
    t.string   "doc_status"
    t.integer  "items_count",           :default => 0
    t.boolean  "estimated",             :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
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
    t.boolean  "submitted"
    t.boolean  "confirmed"
    t.boolean  "approved"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "asset_cost_adjustments", ["asset_id"], :name => "cost_adj_asset"

  create_table "asset_info_adjustments", :force => true do |t|
    t.integer  "asset_id"
    t.date     "effective_date"
    t.string   "asset_name_from"
    t.string   "asset_name_to",         :default => ""
    t.string   "brand_from"
    t.string   "brand_to",              :default => ""
    t.string   "model_from"
    t.string   "model_to",              :default => ""
    t.string   "serial_no_from"
    t.string   "serial_no_to",          :default => ""
    t.boolean  "is_tariff_free_from"
    t.boolean  "is_tariff_free_to",     :default => false
    t.boolean  "is_specific_fund_from"
    t.boolean  "is_specific_fund_to",   :default => false
    t.boolean  "is_vat_free_from"
    t.boolean  "is_vat_free_to",        :default => false
    t.decimal  "vat_from"
    t.decimal  "vat_to",                :default => 0.0
    t.decimal  "vat_rate_from"
    t.decimal  "vat_rate_to",           :default => 0.0
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "confirmed_by_id"
    t.datetime "confirmed_at"
    t.boolean  "confirmed",             :default => false
    t.datetime "approved_at"
    t.integer  "approved_by_id"
    t.boolean  "approved",              :default => false
    t.datetime "rejected_at"
    t.integer  "rejected_by_id"
    t.boolean  "rejected",              :default => false
    t.datetime "submitted_at"
    t.integer  "submitted_by_id"
    t.boolean  "submitted",             :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "asset_info_adjustments", ["asset_id"], :name => "info_adj_asset"

  create_table "asset_transfer_items", :force => true do |t|
    t.string   "type"
    t.integer  "transfering_asset_id"
    t.integer  "asset_allocation_id"
    t.integer  "management_department_id"
    t.integer  "cost_center_id"
    t.integer  "construction_period_id"
    t.integer  "specific_investment_id"
    t.decimal  "allocation_propotion",     :default => 100.0
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "responsible_by"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "asset_transfer_items", ["type"], :name => "trans_items_type"

  create_table "asset_transfers", :force => true do |t|
    t.date     "effective_date",  :default => '2013-10-22'
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "confirmed",       :default => false
    t.integer  "confirmed_by_id"
    t.datetime "confirmed_at"
    t.datetime "approved_at"
    t.boolean  "approved",        :default => false
    t.integer  "approved_by_id"
    t.datetime "rejected_at"
    t.integer  "rejected_by_id"
    t.boolean  "submitted",       :default => false
    t.integer  "submitted_by_id"
    t.datetime "submitted_at"
    t.boolean  "published",       :default => false
    t.datetime "published_at"
    t.integer  "transfer_type"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "assets", :force => true do |t|
    t.string   "asset_no"
    t.string   "device_no"
    t.string   "asset_name"
    t.string   "brand"
    t.string   "model"
    t.string   "specification"
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
    t.decimal  "vat"
    t.decimal  "vat_rate"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "published"
    t.datetime "published_at"
    t.string   "approval_no"
    t.string   "purchase_no"
    t.date     "arrival_date"
    t.string   "design_company"
    t.string   "construction_company"
    t.string   "contract_no"
    t.string   "supplier"
    t.date     "construction_date_from"
    t.date     "construction_date_to"
    t.text     "remark"
    t.boolean  "is_energy_saving",       :default => false
    t.boolean  "is_env_protection",      :default => false
    t.boolean  "is_research_use",        :default => false
    t.boolean  "is_safety_production",   :default => false
    t.boolean  "is_not_any_favorable",   :default => false
    t.boolean  "is_vat_deduction",       :default => false
    t.integer  "accessory_status"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "assets", ["accepted"], :name => "assets_accepted"
  add_index "assets", ["accessory_status"], :name => "assets_acc_stat"
  add_index "assets", ["activated"], :name => "assets_activated"
  add_index "assets", ["asset_no"], :name => "assets_asset_no"
  add_index "assets", ["category_id"], :name => "assets_cat"
  add_index "assets", ["published"], :name => "assets_published"
  add_index "assets", ["sub_category_id"], :name => "assets_sub_cat"

  create_table "documents", :force => true do |t|
    t.text     "description"
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.string   "type"
    t.string   "name"
    t.string   "status"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  create_table "master_data", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.integer  "parent_id"
    t.text     "profiles"
    t.string   "type"
    t.boolean  "enabled",       :default => true
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "master_data", ["enabled"], :name => "master_data_enabled"
  add_index "master_data", ["type", "code"], :name => "master_data_type_code", :unique => true
  add_index "master_data", ["type", "name"], :name => "master_data_type_name"

  create_table "model_relationships", :force => true do |t|
    t.integer  "refer_from_id"
    t.string   "refer_from_type"
    t.integer  "refer_from_status"
    t.integer  "refer_to_id"
    t.string   "refer_to_type"
    t.integer  "refer_to_status"
    t.string   "type"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "number_poolings", :force => true do |t|
    t.string   "type"
    t.string   "serial"
    t.integer  "status"
    t.integer  "owned_by_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "number_poolings", ["owned_by_id"], :name => "number_poolings_owned"
  add_index "number_poolings", ["serial"], :name => "number_poolings_serial"
  add_index "number_poolings", ["status"], :name => "number_poolings_status"
  add_index "number_poolings", ["type"], :name => "number_poolings_type"

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
    t.integer  "department_id"
    t.integer  "cost_center_id"
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
