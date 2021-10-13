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

    def createNewSessionToken
        possibleToken = Faker::Alphanumeric.alphanumeric(number: 20, min_alpha: 3)
        if UserSessionTokenList.find_by(session_token: possibleToken) === nil
            possibleToken
        else
            createNewSessionToken
        end
    end
end