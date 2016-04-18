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

ActiveRecord::Schema.define(version: 20160418200841) do

  create_table "bg_measurements", force: true do |t|
    t.float    "mg_dl"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "patient_name"
    t.integer  "user_id"
    t.string   "user_email_bg_timestamp"
    t.datetime "measurement_time"
    t.string   "time_of_day"
  end

  add_index "bg_measurements", ["user_email_bg_timestamp"], name: "index_bg_measurements_on_user_email_bg_timestamp"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "zipcode"
    t.string   "ip_address"
    t.string   "time_zone"
  end

end
