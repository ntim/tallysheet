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

ActiveRecord::Schema.define(version: 20150115173651) do

  create_table "beverages", force: true do |t|
    t.text     "name"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consumers", force: true do |t|
    t.text     "name"
    t.text     "email"
    t.float    "credit",                   default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount_of_beverages",      default: 0
    t.integer  "amount_of_paid_beverages", default: 0
    t.float    "debt",                     default: 0.0
    t.boolean  "visible",                  default: true
  end

  create_table "tallysheet_entries", force: true do |t|
    t.integer  "consumer_id"
    t.integer  "beverage_id"
    t.integer  "amount",      default: 1
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tallysheet_entries", ["beverage_id"], name: "index_tallysheet_entries_on_beverage_id"
  add_index "tallysheet_entries", ["consumer_id"], name: "index_tallysheet_entries_on_consumer_id"

end
