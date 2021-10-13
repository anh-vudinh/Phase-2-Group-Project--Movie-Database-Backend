# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_13_041111) do

  create_table "user_session_token_lists", force: :cascade do |t|
    t.string "session_token"
    t.time "session_duration"
    t.datetime "exp_start"
    t.datetime "exp_end"
    t.integer "user_id"
    t.index ["user_id"], name: "index_user_session_token_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "useremail"
    t.string "userpwd"
    t.datetime "join_date"
    t.boolean "login_status"
    t.boolean "account_active"
  end

  create_table "watchlist_cards", force: :cascade do |t|
    t.integer "movie_id"
    t.string "movie_name"
    t.string "movie_year"
    t.float "movie_rating"
    t.string "movie_backdrop"
  end

  create_table "watchlist_link_cards", force: :cascade do |t|
    t.integer "watchlist_id"
    t.integer "watchlist_card_id"
    t.index ["watchlist_card_id"], name: "index_watchlist_link_cards_on_watchlist_card_id"
    t.index ["watchlist_id"], name: "index_watchlist_link_cards_on_watchlist_id"
  end

  create_table "watchlists", force: :cascade do |t|
    t.integer "user_id"
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

end
