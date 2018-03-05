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

ActiveRecord::Schema.define(version: 20180304171449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "height"
    t.string   "weight"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "nba_id",             null: false
    t.integer  "team_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["team_id"], name: "index_players_on_team_id", using: :btree
  end

  create_table "stat_sets", force: :cascade do |t|
    t.integer  "player_id"
    t.string   "group_set"
    t.string   "group_value"
    t.integer  "games_played"
    t.integer  "wins"
    t.integer  "losses"
    t.decimal  "w_pct"
    t.decimal  "min"
    t.decimal  "fgm"
    t.decimal  "fg_pct"
    t.decimal  "fga"
    t.decimal  "fg3m"
    t.decimal  "fg3a"
    t.decimal  "fg3_pct"
    t.decimal  "ftm"
    t.decimal  "fta"
    t.decimal  "ft_pct"
    t.decimal  "oreb"
    t.decimal  "dreb"
    t.decimal  "reb"
    t.decimal  "ast"
    t.decimal  "tov"
    t.decimal  "stl"
    t.decimal  "blk"
    t.decimal  "blka"
    t.decimal  "pf"
    t.decimal  "pfd"
    t.decimal  "pts"
    t.decimal  "plus_minus"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["player_id"], name: "index_stat_sets_on_player_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "nba_id",             null: false
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
