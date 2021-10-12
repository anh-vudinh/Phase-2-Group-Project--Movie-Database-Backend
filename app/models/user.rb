class User < ActiveRecord::Base
    has_many :watchlists
    has_many :watchlist_link_cards, through: :watchlists
    has_many :watchlist_cards, through: :watchlist_link_cards
    has_many :user_session_token_lists
end