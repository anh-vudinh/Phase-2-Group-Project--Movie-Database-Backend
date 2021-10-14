class Review < ActiveRecord::Base
    has_many :user_reviews
    has_many :users, through: :user_reviews
    has_many :review_responses
    has_many :responses, through: :review_responses
    has_many :review_movies
    has_many :movies, through: :review_movies
end