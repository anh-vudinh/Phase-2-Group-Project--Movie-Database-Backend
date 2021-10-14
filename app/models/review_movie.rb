class ReviewMovie < ActiveRecord::Base
    belongs_to :review
    belongs_to :movie
end