class ResponsesController < ApplicationController

    get '/responses/getResponses/:review_id' do
        ReviewResponses = ReviewResponse.all.filter{ |rr| rr.review_id == params[:review_id].to_i}
        send = ReviewResponses.map{|e| e.response}
        send.to_json
    end

    post '/responses/addResponse' do
        newDateTime = DateTime.now
        filteredComment = filterScriptFromComment(params[:comment])
        user = UserSessionTokenList.all.find_by(session_token: params[:token]).user     #locate user based off token recieved, return hash for id association
        reviewID = createReviewResponseIfNone(params[:review_id], params[:movie_id])   #some reviews are from TMDB which we will leave as ghost reviews that cannot be in our database, so we create the associations only. otherwise we will have duplicate reviews
        newResponse = Response.create(author: user.username, username: user.username, avatar_path: user.userprofile, content: filteredComment, created_at: newDateTime, updated_at: newDateTime)
        ReviewResponse.create(response_id: newResponse.id, review_id: reviewID)
        newResponse.to_json
    end

    def createReviewResponseIfNone(params_id, params_m_id)
        possibleReview = Review.all.find_by(id: params_id)
        if possibleReview == nil
            newReviewMovie = ReviewMovie.create(movie_id: params_m_id, review_id: params_id)
            newReviewMovie.review_id
        else
            possibleReview.id
        end
    end

    def filterScriptFromComment(comment)
        if comment.include? "&lt;script&gt;"
            filtered1 = comment.gsub!("&lt;script&gt;", "")
            if filtered1.include? "&lt;/script&gt;"
                filtered1.gsub!("&lt;/script&gt;","")
            else
                filtered1
            end
        else
            comment
        end
    end
end