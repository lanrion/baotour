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

ActiveRecord::Schema.define(:version => 20121113172622) do

  create_table "accounts", :force => true do |t|
    t.integer  "customer_id",                :null => false
    t.string   "name",                       :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "bank",        :limit => 200, :null => false
    t.string   "acc",         :limit => 200, :null => false
  end

  create_table "customer_usages", :force => true do |t|
    t.integer  "customer_id", :null => false
    t.integer  "order_id",    :null => false
    t.integer  "hotel_id",    :null => false
    t.integer  "remain"
    t.integer  "cosume",      :null => false
    t.date     "date",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "customer_usages", ["customer_id"], :name => "index_customer_usages_on_customer_id"
  add_index "customer_usages", ["hotel_id"], :name => "index_customer_usages_on_hotel_id"
  add_index "customer_usages", ["order_id"], :name => "index_customer_usages_on_order_id"

  create_table "customers", :force => true do |t|
    t.string   "vip",                                       :null => false
    t.string   "name",                                      :null => false
    t.string   "aka",                                       :null => false
    t.string   "fax"
    t.string   "addr",       :limit => 2000
    t.string   "manager",                                   :null => false
    t.string   "tel",                                       :null => false
    t.integer  "credit",                     :default => 0, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "mobile",     :limit => 20
    t.date     "dob"
  end

  create_table "fund_usages", :force => true do |t|
    t.integer  "customer_id",                       :null => false
    t.integer  "order_id",                          :null => false
    t.integer  "transaction_id",                    :null => false
    t.integer  "order_group_id",                    :null => false
    t.integer  "usage_amount",                      :null => false
    t.boolean  "done",           :default => false
    t.string   "creator",                           :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "fund_usages", ["customer_id"], :name => "index_fund_usages_on_customer_id"
  add_index "fund_usages", ["order_group_id"], :name => "index_fund_usages_on_order_group_id"
  add_index "fund_usages", ["order_id"], :name => "index_fund_usages_on_order_id"
  add_index "fund_usages", ["transaction_id"], :name => "index_fund_usages_on_transaction_id"

  create_table "guides", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hotel_ledgers", :force => true do |t|
    t.integer  "hotel_id",                      :null => false
    t.integer  "order_group_id"
    t.integer  "transfer_id"
    t.string   "rooms"
    t.integer  "night",          :default => 0, :null => false
    t.integer  "cosumption",     :default => 0, :null => false
    t.integer  "credit",         :default => 0, :null => false
    t.integer  "add_amount",     :default => 0, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "hotel_ledgers", ["hotel_id"], :name => "index_hotel_ledgers_on_hotel_id"
  add_index "hotel_ledgers", ["order_group_id"], :name => "index_hotel_ledgers_on_order_group_id"

  create_table "hotels", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "credit",       :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "addr"
    t.string   "telephone"
    t.string   "fax"
    t.string   "sell_tel"
    t.string   "contact_name"
    t.string   "contact_tel"
  end

  create_table "invoice_details", :force => true do |t|
    t.integer  "invoice_id",                :null => false
    t.integer  "amount",                    :null => false
    t.date     "at",                        :null => false
    t.string   "creator",                   :null => false
    t.string   "doc_ref",                   :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "title",      :limit => 200, :null => false
    t.string   "aka"
    t.string   "project"
    t.string   "memo"
  end

  add_index "invoice_details", ["invoice_id"], :name => "index_invoice_details_on_invoice_id"

  create_table "invoices", :force => true do |t|
    t.integer "customer_id", :null => false
    t.integer "issued",      :null => false
    t.integer "remain",      :null => false
  end

  create_table "manage_hotels", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "hotel_id",   :null => false
    t.string   "creator",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "manage_hotels", ["hotel_id"], :name => "index_manage_hotels_on_hotel_id"
  add_index "manage_hotels", ["user_id"], :name => "index_manage_hotels_on_user_id"

  create_table "operators", :force => true do |t|
    t.integer  "customer_id", :null => false
    t.string   "name",        :null => false
    t.string   "mobile",      :null => false
    t.date     "DOB"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "operators", ["customer_id"], :name => "index_operators_on_customer_id"

  create_table "order_groups", :force => true do |t|
    t.integer  "hotel_id",                                      :null => false
    t.string   "ref",                                           :null => false
    t.string   "day_1"
    t.string   "day_2"
    t.string   "day_3"
    t.string   "dinner"
    t.string   "fee",                                           :null => false
    t.integer  "sum",                                           :null => false
    t.integer  "night",                                         :null => false
    t.boolean  "done",                       :default => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.date     "date",                                          :null => false
    t.string   "memo",       :limit => 2000
  end

  add_index "order_groups", ["hotel_id"], :name => "index_order_groups_on_hotel_id"

  create_table "orders", :force => true do |t|
    t.integer  "customer_id",                                       :null => false
    t.integer  "order_group_id",                                    :null => false
    t.string   "operator",                                          :null => false
    t.string   "guide",                                             :null => false
    t.string   "day_1"
    t.string   "day_2"
    t.string   "day_3"
    t.string   "dinner"
    t.integer  "date",                                              :null => false
    t.string   "fee",                                               :null => false
    t.integer  "sum",                            :default => 0,     :null => false
    t.integer  "coverd_amount",                  :default => 0,     :null => false
    t.integer  "uncoverd_amount",                :default => 0,     :null => false
    t.boolean  "all_coverd"
    t.boolean  "done",                           :default => false, :null => false
    t.string   "creator",                                           :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "memo",            :limit => 200
  end

  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"
  add_index "orders", ["order_group_id"], :name => "index_orders_on_order_group_id"

  create_table "refunds", :force => true do |t|
    t.integer  "transaction_id", :null => false
    t.integer  "amount",         :null => false
    t.date     "at",             :null => false
    t.string   "doc_ref",        :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "memo"
    t.string   "operator"
    t.string   "sch_hotel"
    t.string   "sch_date"
    t.string   "refund_acc"
  end

  add_index "refunds", ["transaction_id"], :name => "index_refunds_on_transaction_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "transactions", :force => true do |t|
    t.integer  "customer_id",                                     :null => false
    t.string   "bank",                                            :null => false
    t.string   "account",                                         :null => false
    t.string   "name",                                            :null => false
    t.integer  "amount",                                          :null => false
    t.string   "memo",         :limit => 2000
    t.string   "created_by",                                      :null => false
    t.integer  "used",                         :default => 0
    t.integer  "remain"
    t.boolean  "refund_state",                 :default => false
    t.date     "recv_date",                                       :null => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "account_id"
  end

  add_index "transactions", ["customer_id"], :name => "index_transactions_on_customer_id"

  create_table "transfers", :force => true do |t|
    t.integer  "hotel_id",                       :null => false
    t.date     "date",                           :null => false
    t.string   "out_bank",                       :null => false
    t.string   "out_account",                    :null => false
    t.integer  "amount",                         :null => false
    t.string   "memo"
    t.string   "by",                             :null => false
    t.boolean  "confirm",     :default => false, :null => false
    t.string   "creator",                        :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "transfers", ["hotel_id"], :name => "index_transfers_on_hotel_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name"
    t.boolean  "approved",               :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
