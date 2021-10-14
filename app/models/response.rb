class Response < ActiveRecord::Base
    has_many :user_responses
    has_many :users, through: :user_responses
    has_many :review_responses
    has_many :reviews, through: :review_responses
    has_many :review_movies, through: :reviews
    has_many :movies, through: :review_movies
end