class ReviewResponse < ActiveRecord::Base
    belongs_to :review
    belongs_to :response
end