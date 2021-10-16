class WatchlistCardsController < ApplicationController
    post '/watchlistcards/addWLC' do
        user = UserSessionTokenList.all.find_by(session_token: params[:token]).user     #locate user based off token recieved
        watchlist = createOrFindWL(user.id)                                                       
        newWatchListCard = WatchlistCard.create(movie_id: params[:movie_id], movie_name: params[:movie_name], movie_year: params[:movie_year], movie_rating: params[:movie_rating], movie_backdrop: params[:movie_backdrop])   #create new WLCard
        WatchlistLinkCard.create(watchlist_id: watchlist.id, watchlist_card_id: newWatchListCard.id)   #create the link between WL and WLC
        newWatchListCard.to_json                                                        #send the new WLC back to front end
    end

    patch '/watchlistcards/deleteWLC' do
        user = UserSessionTokenList.all.find_by(session_token: params[:token]).user     #locate user based off token recieved
        watchlist_card = user.watchlist_cards.find_by(movie_id: params[:movie_id])
        watchlist_card.watchlist_link_cards.first.destroy                               #removes the link between WL and WLC
        #watchlist_card.destroy     i want to keep the cards 
        watchlist_card.to_json
    end

    def createOrFindWL(user_id)
        possibleWL = Watchlist.all.find_by(user_id: user_id)                            #check if there is a watchlist associated with user
        if possibleWL == nil
            Watchlist.create(user_id: user_id)                              #if there's no watchlist associated, make one 
        else
            possibleWL                                                      #if there is a current watchlist, store it to pass it's id to create new WL link card
        end                   
    end
end