class ChangeWatchlistCardsDataTypes < ActiveRecord::Migration[6.1]
  def change
    change_table :watchlist_cards do |t|
      t.change :movie_id, :integer
      t.change :movie_rating, :float
    end
  end
end
