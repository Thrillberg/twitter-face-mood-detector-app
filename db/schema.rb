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

ActiveRecord::Schema.define(version: 20150929013312) do

  create_table "collection", force: :cascade do |t|
    t.string   "twitter_account"
    t.string   "image_url"
    t.string   "politician"
    t.string   "text"
    t.string   "date"
    t.string   "mood"
    t.string   "tsentiment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", force: :cascade do |t|
    t.text "twitter_account", null: false
    t.text "img_url",         null: false
    t.text "politician",      null: false
    t.text "text",            null: false
    t.text "date",            null: false
    t.text "mood"
    t.text "sentiment"
  end

  create_table "full_collection", force: :cascade do |t|
    t.text "twitter_account", null: false
    t.text "img_url",         null: false
    t.text "politician",      null: false
    t.text "text",            null: false
    t.text "date",            null: false
  end

end
