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

ActiveRecord::Schema.define(version: 20141204151926) do

  create_table "airports", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "destinations", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.float    "lat"
    t.float    "long"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "neighborhood"
    t.string   "borough"
  end

  create_table "landings", force: true do |t|
    t.integer  "airport_id"
    t.integer  "user_id"
    t.integer  "destination_id"
    t.integer  "ride_id"
    t.time     "arrival_time"
    t.boolean  "complete",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "airline"
    t.string   "flight_num"
    t.date     "arrival_date"
    t.string   "status",         default: "available"
  end

  create_table "rides", force: true do |t|
    t.string   "driver_name"
    t.float    "price"
    t.string   "uber_confirmation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "provider"
    t.string   "uid"
  end

end
