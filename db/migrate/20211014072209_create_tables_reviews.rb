class CreateTablesReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :review_comment
      t.datetime :review_created
    end
    create_table :responses do |t|
      t.string :response_comment
      t.datetime :response_created
    end
    create_table :movies do |t|
      t.integer :movie_id
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
  end
end
