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

ActiveRecord::Schema.define(version: 20150928015607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "env_data", force: :cascade do |t|
    t.float    "wind_speed"
    t.integer  "wind_direction"
    t.float    "temperature"
    t.float    "insol_level"
    t.float    "humidity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "inverters", force: :cascade do |t|
    t.float    "longitude"
    t.float    "latitude"
    t.string   "serial_num"
    t.string   "ip_address"
    t.float    "elevation"
    t.float    "azimuth"
    t.float    "zenith"
    t.float    "time_zone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pv_data", force: :cascade do |t|
    t.float    "dc_voltage"
    t.float    "ac_voltage"
    t.float    "ac_power"
    t.integer  "status"
    t.float    "temperature"
    t.float    "total_kwh"
    t.float    "incident_angle"
    t.integer  "env_datum_id"
    t.integer  "inverter_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "pv_data", ["env_datum_id"], name: "index_pv_data_on_env_datum_id", using: :btree
  add_index "pv_data", ["inverter_id"], name: "index_pv_data_on_inverter_id", using: :btree

  add_foreign_key "pv_data", "env_data"
  add_foreign_key "pv_data", "inverters"
end
