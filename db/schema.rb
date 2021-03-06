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

ActiveRecord::Schema.define(version: 20151203144843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.integer "game_id"
    t.integer "player_1_id"
    t.integer "player_2_id"
    t.integer "rows"
    t.integer "cols"
    t.text    "cells",       array: true
  end

  create_table "games", force: :cascade do |t|
    t.integer "player_1_id"
    t.integer "player_2_id"
    t.integer "board_id"
    t.integer "winner_id"
    t.integer "current_turn_id"
  end

end
