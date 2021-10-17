class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :useremail
      t.string :userpwd
      t.datetime :join_date
      t.boolean :login_status
      t.boolean :account_active
      t.string :userprofile
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
      t.float :movie_rating
      t.string :movie_backdrop
    end

    create_table :user_session_token_lists do |t|
      t.string :session_token
      t.time :session_duration
      t.datetime :exp_start
      t.datetime :exp_end
      t.belongs_to :user
    end

    create_table :reviews do |t|
      t.string :author
      t.string :content
      t.datetime :created_at
      t.datetime :updated_at
      t.string :username
      t.string :avatar_path
      t.integer :rating
    end

    create_table :responses do |t|
      t.string :author
      t.string :content
      t.datetime :created_at
      t.datetime :updated_at
      t.string :username
      t.string :avatar_path
    end

    create_table :movies do |t|
      t.integer :movie_id
      t.string :movie_name
    end

    create_table :user_reviews do |t|
      t.belongs_to :user
      t.belongs_to :review
    end

    create_table :user_responses do |t|
      t.belongs_to :user
      t.belongs_to :response
    end

    create_table :review_responses do |t|
      t.belongs_to :response
      t.belongs_to :review
    end

    create_table :review_movies do |t|
      t.belongs_to :movie
      t.belongs_to :review
    end

    create_table :crackles do |t|
      t.integer :c_id
      t.integer :release_year
      t.string  :title
      t.string :short_title
    end

  end
end
