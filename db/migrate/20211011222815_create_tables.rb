class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :useremail
      t.string :userpwd
      t.datetime :join_date
      t.boolean :login_status
      t.boolean :account_active
    end

    create_table :watchlists do |t|
      t.belongs_to :user
    end

    create_table :watchlist_link_cards do |t|
      t.belongs_to :watchlist
      t.belongs_to :watchlist_card
    end

    create_table :watchlist_cards do |t|
      t.integer :movie_id
      t.string :movie_name
      t.string :movie_year
      t.string :movie_rating
      t.string :movie_backdrop
    end

    create_table :user_session_token_lists do |t|
      t.string :session_token
      t.time :session_duration
      t.datetime :exp_start
      t.datetime :exp_end
      t.belongs_to :user
    end
  end
end
