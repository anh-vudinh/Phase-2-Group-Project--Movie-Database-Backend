class User < ActiveRecord::Base
    has_many :watchlists
    has_many :watchlist_link_cards, through: :watchlists
    has_many :watchlist_cards, through: :watchlist_link_cards
    has_many :user_session_token_lists

    has_many :user_reviews
    has_many :reviews, through: :user_reviews
    has_many :review_movies, through: :reviews
    has_many :movies, through: :reviews_movies
    has_many :user_responses
    has_many :responses, through: :user_responses
end