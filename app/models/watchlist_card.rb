class WatchlistCard < ActiveRecord::Base
    has_many :watchlist_link_cards
    has_many :watchlist, through: :watchlist_link_cards
end