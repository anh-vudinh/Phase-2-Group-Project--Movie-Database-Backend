class Watchlist < ActiveRecord::Base
    has_many :watchlist_link_cards
    has_many :watchlist_cards, through: :watchlist_link_cards
    belongs_to :user
end