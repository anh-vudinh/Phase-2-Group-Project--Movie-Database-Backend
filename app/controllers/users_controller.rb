class UsersController < ApplicationController

    post '/users/register' do
        if User.find_by(username: params[:username]) == nil #allow newUser create
            newUser = User.create(username: params[:username], useremail: nil, userpwd: params[:password], login_status: true, account_active: true, join_date: DateTime.now)
            newToken = createNewSessionToken
            UserSessionTokenList.create( user_id: newUser.id, session_token: newToken, session_duration: 1, exp_start: DateTime.now, exp_end:DateTime.now+1)
            newToken.to_json
        else
            "user_exist".to_json
        end
    end

    post '/users/login' do
        searchUser = User.find_by(username: params[:username])
        if searchUser != nil 
            if searchUser.userpwd == params[:password]                     #allow newUser login
                possibleToken = searchUser.user_session_token_lists.find {|ustl| ustl.exp_end >= DateTime.now}
                if possibleToken != nil                                    #user has no expired usable session token
                    possibleToken.session_token.to_json                    #so return token to front end
                else
                    newToken = createNewSessionToken                       #user does not have usable token, create new token
                    UserSessionTokenList.create( user_id: searchUser.id, session_token: newToken, session_duration: 1, exp_start: DateTime.now, exp_end:DateTime.now+1)
                    newToken.to_json                                       #return to front end
                end 
            else
                "wrong_pwd".to_json                                         #wrong password
            end
        else                                                                #no user exist
            "no_user".to_json
        end
    end

    post '/users/addWLC' do
        user = UserSessionTokenList.all.find_by(session_token: params[:token]).user     #locate user based off token recieved
        possibleWL = Watchlist.all.find_by(user_id: user.id)                            #check if there is a watchlist associated with user
        if possibleWL == nil
            watchlist = Watchlist.create(user_id: user.id)                              #if there's no watchlist associated, make one 
        else
            watchlist = possibleWL                                                      #if there is a current watchlist, store it to pass it's id to create new WL link card
        end                                                                                  
        newWatchListCard = WatchlistCard.create(movie_id: params[:movie_id], movie_name: params[:movie_name], movie_year: params[:movie_year], movie_rating: params[:movie_rating], movie_backdrop: params[:movie_backdrop])   #create new WLCard
        WatchlistLinkCard.create(watchlist_id: watchlist.id, watchlist_card_id: newWatchListCard.id)   #create the link between WL and WLC
        newWatchListCard.to_json                                                        #send the new WLC back to front end
    end

    post '/users/retrieveWL' do
        UserSessionTokenList.all.find_by(session_token: params[:token]).user.watchlist_cards.to_json     #locate user based off token recieved
    end

    patch '/users/deleteWLC' do
        user = UserSessionTokenList.all.find_by(session_token: params[:token]).user     #locate user based off token recieved
        watchlist_card = user.watchlist_cards.find_by(movie_id: params[:movie_id])
        watchlist_card.watchlist_link_cards.first.destroy
        watchlist_card.destroy
        watchlist_card.to_json
    end

    post '/users/addReview' do
        binding.pry
        newDateTime = DateTime.now
        filteredComment = filterScriptFromComment(params[:comment])
        user = UserSessionTokenList.all.find_by(session_token: params[:token]).user     #locate user based off token recieved, return hash for id association
        movie = createMovieIfNone(params[:movie_id], params[:movie_name])                                    #create or find movie, return hash for id association
        newReview = Review.create(author: user.username, username: user.username, avatar_path: user.userprofile, rating: params[:rating], content: filteredComment, created_at: newDateTime, updated_at: newDateTime)
        UserReview.create(user_id: user.id, review_id: newReview.id)
        ReviewMovie.create(review_id: newReview.id, movie_id: movie.id)
        newReview.to_json
    end

    post '/users/addResponse' do
        newDateTime = DateTime.now
        filteredComment = filterScriptFromComment(params[:comment])
        user = UserSessionTokenList.all.find_by(session_token: params[:token]).user     #locate user based off token recieved, return hash for id association
        reviewID = createReviewResponseIfNone(params[:review_id], params[:movie_id])   #some reviews are from TMDB which we will leave as ghost reviews that cannot be in our database, so we create the associations only. otherwise we will have duplicate reviews
        newResponse = Response.create(author: user.username, username: user.username, avatar_path: user.userprofile, content: filteredComment, created_at: newDateTime, updated_at: newDateTime)
        ReviewResponse.create(response_id: newResponse.id, review_id: reviewID)
        newResponse.to_json
    end

    get '/users/getReviews/:movie_id' do
        Movie.find_by(movie_id: params[:movie_id]).reviews.to_json
    end

    get '/users/getResponses/:review_id' do
        ReviewResponses = ReviewResponse.all.filter{ |rr| rr.review_id == params[:review_id].to_i}
        send = ReviewResponses.map{|e| e.response}
        send.to_json
    end

    def createNewSessionToken
        possibleToken = Faker::Alphanumeric.alphanumeric(number: 20, min_alpha: 3)
        if UserSessionTokenList.find_by(session_token: possibleToken) == nil
            possibleToken
        else
            createNewSessionToken
        end
    end

    def createMovieIfNone(params_id, params_m_name)
        possibleMovie = Movie.all.find_by(movie_id: params_id)
        if possibleMovie == nil
            Movie.create(movie_id: params_id, movie_name: params_m_name)
        else
            possibleMovie  
        end
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