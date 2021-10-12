class WatchlistLinkCard < ActiveRecord::Base
    belongs_to :watchlist
    belongs_to :watchlist_card
end