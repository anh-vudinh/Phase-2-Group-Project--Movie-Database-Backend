class Movie < ActiveRecord::Base
    has_many :review_movies
    has_many :reviews, through: :review_movies
    has_many :review_responses, through: :reviews
    has_many :responses, through: :review_responses
    has_many :users_reviews, through: :reviews
    has_many :users, through: :user_reviews
end