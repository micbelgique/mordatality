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

ActiveRecord::Schema.define(version: 20150801113624) do

  create_table "births", force: :cascade do |t|
    t.integer "age",         limit: 4
    t.decimal "probability",           precision: 10, scale: 8
  end

  create_table "cities", force: :cascade do |t|
    t.string  "name_fr",     limit: 255
    t.string  "name_nl",     limit: 255
    t.integer "kind",        limit: 4
    t.integer "zip",         limit: 4
    t.decimal "latitude",                precision: 16, scale: 12
    t.decimal "longitude",               precision: 16, scale: 12
    t.integer "province_id", limit: 4
    t.decimal "area",                    precision: 6,  scale: 2
    t.integer "population",  limit: 4
    t.integer "density",     limit: 4
  end

  create_table "mortalities", force: :cascade do |t|
    t.integer "province_id",           limit: 4
    t.string  "gender",                limit: 255
    t.integer "age",                   limit: 4
    t.integer "sample_population",     limit: 4
    t.integer "observed_deaths",       limit: 4
    t.decimal "death_probability",                 precision: 8,  scale: 6
    t.decimal "survivors",                         precision: 12, scale: 4
    t.decimal "observed_table_deaths",             precision: 12, scale: 4
    t.decimal "life_expectancy",                   precision: 4,  scale: 2
  end

  create_table "provinces", force: :cascade do |t|
    t.string  "name_fr",   limit: 255
    t.string  "name_nl",   limit: 255
    t.string  "name_en",   limit: 255
    t.decimal "latitude",              precision: 10, scale: 6
    t.decimal "longitude",             precision: 10, scale: 6
  end

end
