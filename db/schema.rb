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

ActiveRecord::Schema.define(version: 2021_10_14_074042) do

  create_table "movies", force: :cascade do |t|
    t.integer "movie_id"
  end

  create_table "responses", force: :cascade do |t|
    t.string "response_comment"
    t.datetime "response_created"
  end

  create_table "review_movies", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "review_id"
    t.index ["movie_id"], name: "index_review_movies_on_movie_id"
    t.index ["review_id"], name: "index_review_movies_on_review_id"
  end

  create_table "review_responses", force: :cascade do |t|
    t.integer "response_id"
    t.integer "review_id"
    t.index ["response_id"], name: "index_review_responses_on_response_id"
    t.index ["review_id"], name: "index_review_responses_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "review_comment"
    t.datetime "review_created"
  end

  create_table "user_responses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "response_id"
    t.index ["response_id"], name: "index_user_responses_on_response_id"
    t.index ["user_id"], name: "index_user_responses_on_user_id"
  end

  create_table "user_reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "review_id"
    t.index ["review_id"], name: "index_user_reviews_on_review_id"
    t.index ["user_id"], name: "index_user_reviews_on_user_id"
  end

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
    t.string "userprofile"
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
